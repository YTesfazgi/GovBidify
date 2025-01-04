defmodule GovBidify.NAICSParser do
  use GenServer
  alias GovBidify.Repo
  alias GovBidify.NAICSCode
  require Logger

  @xlsx_file_path "priv/static/files/2-6 Digit 2022 NAICS Codes.xlsx"

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
    case Repo.aggregate(NAICSCode, :count) do
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
        Logger.info("NAICSCodes table already contains #{count} records. Skipping import.")
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
        # Handle both float and non-float values
        code = case Enum.at(row, 0) do
          float when is_float(float) ->
            float
            |> Float.to_string()
            |> String.replace(".0", "")
          other ->
            to_string(other)
        end

        case %NAICSCode{}
             |> NAICSCode.changeset(%{
               code: code,
               description: Enum.at(row, 1)
             })
             |> Repo.insert() do
          {:ok, _record} ->
            {success_count + 1, failures}
          {:error, changeset} ->
            {success_count, [{code, changeset.errors} | failures]}
        end
      end)

    case failed do
      [] ->
        Logger.info("Successfully inserted all #{successful} NAICS codes.")
      failed_entries ->
        Logger.info("Inserted #{successful} NAICS codes with #{length(failed_entries)} failures")
        Logger.error("Failed entries: #{inspect(failed_entries)}")
    end
  end
end
