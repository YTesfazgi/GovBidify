defmodule Mix.Tasks.GovBidify.GenerateStaticData do
  @moduledoc """
  Generates static data files for offices and set_asides from the database.

  ## Examples

      mix gov_bidify.generate_static_data

  """
  use Mix.Task
  alias GovBidify.Opportunities

  @shortdoc "Generates static data files for offices and set_asides"
  def run(_) do
    Mix.Task.run("app.start")

    IO.puts("Generating static data files...")

    # Update offices static data
    case Opportunities.update_offices_static_data() do
      :ok -> IO.puts("Successfully updated offices static data.")
      {:error, reason} -> IO.puts("Error updating offices static data: #{inspect(reason)}")
    end

    # Update set_asides static data
    case Opportunities.update_set_asides_static_data() do
      :ok -> IO.puts("Successfully updated set_asides static data.")
      {:error, reason} -> IO.puts("Error updating set_asides static data: #{inspect(reason)}")
    end

    IO.puts("Static data generation complete.")
  end
end
