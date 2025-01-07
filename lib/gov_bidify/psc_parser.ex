defmodule GovBidify.PSC_Parser do
  use GenServer
  alias GovBidify.Repo
  alias GovBidify.PSC_Code
  require Logger

  @xlsx_file_path "priv/static/files/PSC Codes April 2024.xlsx"

  # Public API
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # GenServer Callbacks
  @impl true
  def init(state) do
    send(self(), :parse_and_insert)
    {:ok, state}
  end

  @impl true
  def handle_info(:parse_and_insert, state) do
    case Repo.aggregate(PSC_Code, :count) do
      0 ->
        # Table is empty, proceed with parsing and inserting
        case parse_xlsx(@xlsx_file_path) do
          {:ok, data} ->
            insert_data(data)
            {:noreply, state}

          {:error, reason} ->
            Logger.error("Failed to parse XLSX file: #{inspect(reason)}")
            {:noreply, state}
        end
      count ->
        Logger.info("PSC_Codes table contains #{count}/6107 records. Skipping import.")
        {:noreply, state}
    end
  end

  # Helper Functions
  defp parse_xlsx(file_path) do
    try do
      {:ok, pid} = Xlsxir.multi_extract(file_path, 0)
      data = Xlsxir.get_list(pid)
      Xlsxir.close(pid)
      {:ok, data}
    rescue
      exception ->
        {:error, exception}
    end
  end

  defp insert_data(data) do
    {successful, failed} =
      Enum.reduce(data, {0, []}, fn row, {success_count, failures} ->
        # Handle both float and non-float values for psc_code
        psc_code = case Enum.at(row, 0) do
          float when is_float(float) ->
            float
            |> Float.to_string()
            |> String.replace(".0", "")
          other ->
            to_string(other)
        end

        # Ensure string fields are properly converted
        attrs = %{
          psc_code: psc_code,
          product_and_service_code_name: to_string(Enum.at(row, 1) || ""),
          start_date: Enum.at(row, 2),
          end_date: Enum.at(row, 3),
          product_and_service_code_full_name: to_string(Enum.at(row, 4) || ""),
          product_and_service_code_includes: to_string(Enum.at(row, 5) || ""),
          product_and_service_code_excludes: to_string(Enum.at(row, 6) || ""),
          product_and_service_notes: to_string(Enum.at(row, 7) || ""),
          parent_psc_code: to_string(Enum.at(row, 8) || ""),
          psc_category: to_string(Enum.at(row, 9) || ""),
          level_1_category_code: Enum.at(row, 10),
          level_1_category: to_string(Enum.at(row, 11) || ""),
          level_2_category_code: Enum.at(row, 12),
          level_2_category: to_string(Enum.at(row, 13) || "")
        }

        case %PSC_Code{}
             |> PSC_Code.changeset(attrs)
             |> Repo.insert() do
          {:ok, _record} ->
            {success_count + 1, failures}
          {:error, changeset} ->
            {success_count, [{psc_code, changeset.errors} | failures]}
        end
      end)

    case failed do
      [] ->
        Logger.info("Successfully inserted all #{successful} PSC codes.")
      failed_entries ->
        Logger.info("Inserted #{successful} PSC codes with #{length(failed_entries)} failures")
        Logger.error("Failed entries: #{inspect(failed_entries)}")
    end
  end
end
