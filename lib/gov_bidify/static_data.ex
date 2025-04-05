defmodule GovBidify.StaticData do
  @moduledoc """
  Module for loading and retrieving static data used throughout the application.
  """

  @doc """
  Get a list of opportunity types.
  """
  def list_types do
    load_json("types.json")
  end

  @doc """
  Get a map of department codes to names.
  """
  def list_departments do
    load_json("departments.json")
  end

  @doc """
  Get a map of sub-tier codes to names.
  """
  def list_sub_tiers do
    load_json("sub_tiers.json")
  end

  @doc """
  Get a list of office names.
  """
  def list_offices do
    load_json("offices.json")
  end

  @doc """
  Get a list of set aside types.
  """
  def list_set_asides do
    load_json("set_asides.json")
  end

  @doc """
  Get a map of country codes to names.
  """
  def list_countries do
    load_json("countries.json")
  end

  @doc """
  Get a map of state codes to names.
  """
  def list_states do
    load_json("states.json")
  end

  @doc """
  Update the offices list from the database.
  This should be called periodically to refresh the static data from the database.
  """
  def update_offices(offices) do
    file_path = Path.join(:code.priv_dir(:gov_bidify), "static_data/offices.json")

    case Jason.encode(offices) do
      {:ok, json} -> File.write(file_path, json)
      {:error, reason} ->
        require Logger
        Logger.error("Failed to encode offices: #{inspect(reason)}")
        {:error, reason}
    end
  end

  @doc """
  Update the set asides list from the database.
  This should be called periodically to refresh the static data from the database.
  """
  def update_set_asides(set_asides) do
    file_path = Path.join(:code.priv_dir(:gov_bidify), "static_data/set_asides.json")

    case Jason.encode(set_asides) do
      {:ok, json} -> File.write(file_path, json)
      {:error, reason} ->
        require Logger
        Logger.error("Failed to encode set asides: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # Private helper to load JSON from static_data directory
  defp load_json(filename) do
    file_path = Path.join(:code.priv_dir(:gov_bidify), ["static_data/", filename])

    with {:ok, body} <- File.read(file_path),
         {:ok, json} <- Jason.decode(body) do
      json
    else
      {:error, reason} ->
        # Log error but return empty result to avoid breaking the app
        require Logger
        Logger.error("Failed to load static data file #{filename}: #{inspect(reason)}")
        case File.exists?(file_path) do
          true -> %{} # File exists but couldn't be parsed
          false -> [] # File doesn't exist, return empty list/map based on expected type
        end
    end
  end
end
