defmodule SamApiClientBehaviour do
  @moduledoc """
  Defines the behavior for the SAM API client.
  """

  @doc """
  Makes a request to the SAM Get Opportunities API with the given parameters.

  ## Parameters
    - params: A map with string keys representing the request parameters.

  ## Returns
    - `{:ok, map}` on success
    - `{:error, term}` on failure
  """
  @callback get_opportunities(limit :: integer(), params :: %{required(String.t()) => any}) :: {:ok, map} | {:error, term}

  def get_opportunities(limit, params), do: impl().get_opportunities(limit, params)
  defp impl, do: Application.get_env(:gov_bidify, :sam_api_client, SamApiClient)
end
