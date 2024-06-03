defmodule SamClient do
  @moduledoc """
  Module for SAM.gov Get Opportunities Public API
  """

  @sam_api_url Application.compile_env!(:gov_bidify, :sam_api_url)
  @sam_api_key Application.compile_env!(:gov_bidify, :sam_api_key)

  @doc """
  Performs a search via SAM.gov Get Opportunities API.

  Returns `{:ok, json}`.

  ## Example

    iex> SamClient.search(%{"postedFrom" => "01/01/2018", "postedTo" => "05/10/2018", "ptype" => "a", "deptname" => "general"})
    {:ok,
      %{
        "limit" => 10,
        "links" => [
          %{
            "href" => "null/opportunities/v2/search?limit=10&postedFrom=01/01/2018&postedTo=05/10/2018&title=Driving",
            "rel" => "self"
          }
        ],
        "offset" => 0,
        "opportunitiesData" => [],
        "totalRecords" => 0
      }
    }
  """
  def search(params) do
    {:ok, response} = Finch.build(:get, build_url(params))
    |> Finch.request(GovBidify.Finch)

    {:ok, _json} = Jason.decode(response.body)
  end

  defp build_url(params) do
    request_params = params
    |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
    |> Enum.join("&")

    @sam_api_url <> @sam_api_key <> "&" <> request_params
  end
end
