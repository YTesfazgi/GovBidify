defmodule SamClient do
  @moduledoc """
  Module for SAM.gov Get Opportunities Public API
  """

  @sam_api_url Application.compile_env!(:gov_bidify, :sam_api_url)
  @sam_api_key Application.compile_env!(:gov_bidify, :sam_api_key)

  def search(params) do
    Finch.build(:get, build_url(params)) |> Finch.request(GovBidify.Finch)
  end

  defp build_url(params) do
    request_params = params
    |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
    |> Enum.join("&")

    @sam_api_url <> @sam_api_key <> "&" <> request_params
  end
end
