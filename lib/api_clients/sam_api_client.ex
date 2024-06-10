defmodule SamApiClient do
  @moduledoc """
  Module for SAM.gov Get Opportunities Public API
  """

  @behaviour SamApiClientBehaviour

  # will likely need to adjust limit, maybe remove in the future since this is for updating database
  @sam_api_url "https://api.sam.gov/prod/opportunities/v2/search?limit=1&api_key="
  @sam_api_key Application.compile_env!(:gov_bidify, :sam_api_key)

  @doc """
  Performs a search via SAM.gov Get Opportunities API.

  Returns `{:ok, json}`.

  ## Example

    SamApiClient.get_opportunities(10, %{"postedFrom" => "01/01/2024", "postedTo" => "05/10/2024", "title" => "Driving"})
    {:ok,
      %{
        "limit" => 10,
        "links" => [
          %{
            "href" => "null/opportunities/v2/search?limit=10&postedFrom=01/01/2024&postedTo=05/10/2024&title=Driving",
            "rel" => "self"
          }
        ],
        "offset" => 0,
        "opportunitiesData" => [...],
        "totalRecords" => 843
      }
    }
  """
  @impl true
  def get_opportunities(limit, params) do
    request_params =
      params
      |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
      |> Enum.join("&")

    url = "limit=#{limit}&" <> @sam_api_url <> @sam_api_key <> "&" <> request_params

    {:ok, response} =
      Finch.build(:get, url)
      |> Finch.request(GovBidify.Finch)

    {:ok, _json} = Jason.decode(response.body)
  end
end
