defmodule GovBidify.EntityParser do
  use GenServer
  alias GovBidify.Repo
  alias GovBidify.Entities.Entity
  require Logger

  @data_file_path Application.compile_env(:gov_bidify, :entity_data_file_path, "priv/data/entities.dat")
  @max_string_length 255 # Default max string length for varchar fields
  @log_frequency 1000    # Log progress every N records

  # Public API
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # Manual trigger function to start the import process: GovBidify.EntityParser.import_entities()
  def import_entities(force \\ false) do
    GenServer.call(__MODULE__, {:import_entities, force}, :infinity)
  end

  # Function to copy external data file to project
  def copy_external_file_to_project(source_path, dest_path \\ nil) do
    dest_path = dest_path || "priv/data/entities.dat"

    # Create directory if it doesn't exist
    dest_dir = Path.dirname(dest_path)
    unless File.exists?(dest_dir) do
      File.mkdir_p!(dest_dir)
    end

    # Copy the file
    case File.cp(source_path, dest_path) do
      :ok ->
        Logger.info("Successfully copied data file to #{dest_path}")
        {:ok, dest_path}
      {:error, reason} ->
        Logger.error("Failed to copy data file: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # GenServer Callbacks
  @impl true
  def init(state) do
    {:ok, state}
  end

  # Handle the manual import call
  @impl true
  def handle_call({:import_entities, force}, _from, state) do
    Logger.info("EntityParser: Manual import triggered (force=#{force})")

    result = case Repo.aggregate(Entity, :count) do
      0 ->
        # Table is empty, proceed with parsing and inserting
        Logger.info("EntityParser: Table is empty, beginning import")
        process_import()

      count when force ->
        # Force import even though data exists
        Logger.info("EntityParser: Force importing despite existing #{count} records")
        process_import()

      count ->
        # Skip import as data already exists
        Logger.info("EntityParser: Entities table contains #{count} records. Skipping import.")
        {:skipped, "Table already contains #{count} records"}
    end

    {:reply, result, state}
  end

  # Process the actual import logic
  defp process_import do
    case parse_data(@data_file_path) do
      {:ok, data} ->
        Logger.info("EntityParser: Successfully parsed #{length(data)} records, beginning database insertion")
        result = insert_data(data)
        Logger.info("EntityParser: Import process complete")
        {:ok, result}

      {:error, reason} = error ->
        Logger.error("EntityParser: Failed to parse data file: #{inspect(reason)}")
        error
    end
  end

  defp parse_data(file_path) do
    try do
      Logger.info("EntityParser: Opening data file at #{file_path}")

      # Check if file exists before attempting to stream
      unless File.exists?(file_path) do
        Logger.error("EntityParser: Data file does not exist at path: #{file_path}")
        throw({:error, :file_not_found})
      end

      # Get file size for logging
      {:ok, %{size: file_size}} = File.stat(file_path)
      Logger.info("EntityParser: Data file size: #{file_size} bytes")

      Logger.info("EntityParser: Beginning to read and parse data file")

      # Add a counter for progress logging
      entities =
        File.stream!(file_path)
        |> Stream.map(&String.trim/1)
        |> Stream.drop(1) # Skip the header row
        |> Stream.with_index()
        |> Stream.map(fn {line, index} ->
          # Log progress periodically
          if rem(index + 1, @log_frequency) == 0 do
            Logger.info("EntityParser: Processed #{index + 1} records so far")
          end

          line
        end)
        |> Stream.map(&String.split(&1, "|"))
        |> Stream.map(&map_to_entity/1)
        |> Enum.to_list()

      Logger.info("EntityParser: Completed parsing #{length(entities)} entities")
      {:ok, entities}
    rescue
      e ->
        Logger.error("EntityParser: Error parsing entity data: #{Exception.message(e)}")
        Logger.error("EntityParser: Stack trace: #{Exception.format_stacktrace(__STACKTRACE__)}")
        {:error, e}
    catch
      {:error, reason} ->
        Logger.error("EntityParser: Error during parsing: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # Map columns to Entity struct based on the DAT file format
  defp map_to_entity(columns) do
    # Parse dates if they exist and aren't empty
    parse_date = fn index ->
      date_str = Enum.at(columns, index, "")
      case date_str do
        "" -> nil
        _ ->
          case Date.from_iso8601("#{String.slice(date_str, 0, 4)}-#{String.slice(date_str, 4, 2)}-#{String.slice(date_str, 6, 2)}") do
            {:ok, date} -> date
            _ -> nil
          end
      end
    end

    # Safely get string value and truncate if needed
    safe_string = fn index ->
      value = Enum.at(columns, index, "")
      truncate_string(value)
    end

    # Log the first few records to debug column mapping
    if length(columns) > 10 do
      # Debug output of the first 10 columns to help fix mapping
      first_cols = columns |> Enum.take(10) |> Enum.with_index() |> Enum.map(fn {val, idx} -> "#{idx}:'#{val}'" end) |> Enum.join(", ")
      Logger.debug("EntityParser: First 10 columns: #{first_cols}")
    end

    # Map columns to Entity struct based on the DAT file format
    %Entity{
      unique_entity_id: safe_string.(0),
      blank_deprecated: safe_string.(1),
      entity_eft_indicator: safe_string.(2),
      cage_code: safe_string.(3),
      dodaac: safe_string.(4),
      sam_extract_code: safe_string.(5),
      purpose_of_registration: safe_string.(6),
      initial_registration_date: parse_date.(7),
      registration_expiration_date: parse_date.(8),
      last_update_date: parse_date.(9),
      activation_date: parse_date.(10),
      legal_business_name: safe_string.(11),
      dba_name: safe_string.(12),
      entity_division_name: safe_string.(13),
      entity_division_number: safe_string.(14),
      physical_address_line_1: safe_string.(15),
      physical_address_line_2: safe_string.(16),
      physical_address_city: safe_string.(17),
      physical_address_province_or_state: safe_string.(18),
      physical_address_zip_postal_code: safe_string.(19),
      physical_address_zip_code_4: safe_string.(20),
      physical_address_country_code: safe_string.(21),
      physical_address_congressional_district: safe_string.(22),
      d_b_open_data_flag: safe_string.(23),
      entity_start_date: parse_date.(24),
      fiscal_year_end_close_date: parse_date.(25),
      # company_security_level: ,
      # highest_employee_security_level: ,
      entity_url: safe_string.(26),
      entity_structure: safe_string.(27),
      state_of_incorporation: safe_string.(28),
      country_of_incorporation: safe_string.(29),
      business_type_counter: safe_string.(30),
      bus_type_string: safe_string.(31),
      # agency_business_purpose: ,
      primary_naics: safe_string.(32),
      naics_code_counter: safe_string.(33),
      naics_code_string: safe_string.(34),
      psc_code_counter: safe_string.(35),
      psc_code_string: safe_string.(36),
      credit_card_usage: safe_string.(37),
      correspondence_flag: safe_string.(38),
      mailing_address_line_1: safe_string.(39),
      mailing_address_line_2: safe_string.(40),
      mailing_address_city: safe_string.(41),
      mailing_address_zip_postal_code: safe_string.(42),
      mailing_address_zip_code_4: safe_string.(43),
      mailing_address_country: safe_string.(44),
      mailing_address_state_or_province: safe_string.(45),
      govt_bus_poc_first_name: safe_string.(46),
      govt_bus_poc_middle_initial: safe_string.(47),
      govt_bus_poc_last_name: safe_string.(48),
      govt_bus_poc_title: safe_string.(49),
      govt_bus_poc_st_add_1: safe_string.(50),
      govt_bus_poc_st_add_2: safe_string.(51),
      govt_bus_poc_city: safe_string.(52),
      govt_bus_poc_zip_postal_code: safe_string.(53),
      govt_bus_poc_zip_code_4: safe_string.(54),
      govt_bus_poc_country_code: safe_string.(55),
      govt_bus_poc_state_or_province: safe_string.(56),
      # govt_bus_poc_us_phone: ,
      # govt_bus_poc_us_phone_ext: ,
      # govt_bus_poc_non_us_phone: ,
      # govt_bus_poc_fax_us_only: ,
      # govt_bus_poc_email: ,
      alt_govt_bus_poc_first_name: safe_string.(57),
      alt_govt_bus_poc_middle_initial: safe_string.(58),
      alt_govt_bus_poc_last_name: safe_string.(59),
      alt_govt_bus_poc_title: safe_string.(60),
      alt_govt_bus_poc_st_add_1: safe_string.(61),
      alt_govt_bus_poc_st_add_2: safe_string.(62),
      alt_govt_bus_poc_city: safe_string.(63),
      alt_govt_bus_poc_zip_postal_code: safe_string.(64),
      alt_govt_bus_poc_zip_code_4: safe_string.(65),
      alt_govt_bus_poc_country_code: safe_string.(66),
      alt_govt_bus_poc_state_or_province: safe_string.(67),
      # alt_govt_bus_poc_us_phone: ,
      # alt_govt_bus_poc_us_phone_ext: ,
      # alt_govt_bus_poc_non_us_phone: ,
      # alt_govt_bus_poc_fax_us_only: ,
      # alt_govt_bus_poc_email: ,
      past_perf_poc_poc_first_name: safe_string.(68),
      past_perf_poc_poc_middle_initial: safe_string.(69),
      past_perf_poc_poc_last_name: safe_string.(70),
      past_perf_poc_poc_title: safe_string.(71),
      past_perf_poc_st_add_1: safe_string.(72),
      past_perf_poc_st_add_2: safe_string.(73),
      past_perf_poc_city: safe_string.(74),
      past_perf_poc_zip_postal_code: safe_string.(75),
      past_perf_poc_zip_code_4: safe_string.(76),
      past_perf_poc_country_code: safe_string.(77),
      past_perf_poc_state_or_province: safe_string.(78),
      # past_perf_poc_us_phone: ,
      # past_perf_poc_us_phone_ext: ,
      # past_perf_poc_non_us_phone: ,
      # past_perf_poc_fax_us_only: ,
      # past_perf_poc_email: ,
      alt_past_perf_poc_first_name: safe_string.(79),
      alt_past_perf_poc_middle_initial: safe_string.(80),
      alt_past_perf_poc_last_name: safe_string.(81),
      alt_past_perf_poc_title: safe_string.(82),
      alt_past_perf_poc_st_add_1: safe_string.(83),
      alt_past_perf_poc_st_add_2: safe_string.(84),
      alt_past_perf_poc_city: safe_string.(85)
    }
  end

  # Safely truncate strings to avoid database errors
  defp truncate_string(nil), do: nil
  defp truncate_string(value) when is_binary(value) do
    if String.length(value) > @max_string_length do
      String.slice(value, 0, @max_string_length)
    else
      value
    end
  end
  defp truncate_string(value), do: value

  defp insert_data(data) do
    total_count = length(data)
    Logger.info("EntityParser: Beginning to insert #{total_count} records into database")

    start_time = :os.system_time(:millisecond)
    error_threshold = 10 # Show warning after this many consecutive errors

    {success_count, error_count, _consecutive_errors} = Enum.reduce_while(
      Enum.with_index(data),
      {0, 0, 0},
      fn {entity, index}, {successes, errors, consecutive} ->
        # Log progress periodically
        if rem(index + 1, @log_frequency) == 0 do
          elapsed_ms = :os.system_time(:millisecond) - start_time
          rate = if elapsed_ms > 0, do: index * 1000 / elapsed_ms, else: 0
          pct_complete = index * 100 / total_count
          Logger.info("EntityParser: Inserted #{index + 1}/#{total_count} records (#{Float.round(pct_complete, 1)}%) - #{Float.round(rate, 1)} records/sec - #{successes} successful, #{errors} failed")

          # Early warning if no successful inserts after processing many records
          if successes == 0 && index >= 100 do
            Logger.warning("EntityParser: WARNING - No successful inserts after processing #{index + 1} records. Import may be failing.")
          end
        end

        entity_map = entity
        |> Map.from_struct()
        |> Map.drop([:__meta__])

        # Create a changeset with only the fields that are present
        changeset = Entity.changeset(%Entity{}, entity_map)

        case safe_insert(changeset) do
          {:ok, _} ->
            # Reset consecutive error counter on success
            {:cont, {successes + 1, errors, 0}}

          {:error, reason} ->
            # Count consecutive errors for early detection of problems
            new_consecutive = consecutive + 1

            # Log the first 5 errors in detail, then just log periodically
            if errors < 5 || rem(errors, 50) == 0 do
              Logger.error("EntityParser: Insertion error #{errors + 1} at record #{index + 1}: #{inspect(reason)}")
              # Log the entity data for the first few errors to help diagnose
              if errors < 3 do
                Logger.error("EntityParser: Problem entity: #{inspect(entity_map)}")
              end
            end

            # Warn if many consecutive errors - might indicate a systematic problem
            if new_consecutive == error_threshold do
              Logger.warning("EntityParser: WARNING - #{error_threshold} consecutive insertion failures. There may be a systematic issue.")
            end

            # Halt processing if extremely high error rate persists
            if errors > 100 && successes == 0 do
              Logger.error("EntityParser: CRITICAL - 100% failure rate after 100+ records. Halting import.")
              {:halt, {successes, errors + 1, new_consecutive}}
            else
              {:cont, {successes, errors + 1, new_consecutive}}
            end
        end
      end
    )

    elapsed_sec = (:os.system_time(:millisecond) - start_time) / 1000
    rate = if elapsed_sec > 0, do: success_count / elapsed_sec, else: 0

    if success_count == 0 && error_count > 0 do
      Logger.error("EntityParser: IMPORT FAILED - All #{error_count} records failed to insert")
    else
      Logger.info("EntityParser: Import complete - #{success_count} records inserted, #{error_count} errors in #{Float.round(elapsed_sec, 1)} seconds (#{Float.round(rate, 1)} records/sec)")
    end

    {success_count, error_count}
  end

  # Safely attempt an insert, catching any errors
  defp safe_insert(changeset) do
    try do
      Repo.insert(changeset, [returning: false])
    rescue
      e ->
        error_msg = Exception.message(e)
        Logger.error("EntityParser: Failed to insert entity (#{inspect(changeset.changes[:unique_entity_id] || "unknown")}): #{error_msg}")
        {:error, error_msg}
    catch
      kind, reason ->
        msg = "#{kind}: #{inspect(reason)}"
        Logger.error("EntityParser: Caught error while inserting: #{msg}")
        {:error, msg}
    end
  end
end
