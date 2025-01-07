defmodule GovBidify.PSC_Codes do
  alias GovBidify.Repo
  alias GovBidify.PSC_Code

  def list_psc_codes do
    Repo.all(PSC_Code)
    |> Enum.reduce(%{}, fn psc, acc ->
      name = if psc.product_and_service_code_full_name do
        psc.product_and_service_code_full_name
      else
        psc.product_and_service_code_name
        |> to_string()
        |> String.split(" ")
        |> Enum.map(&String.capitalize/1)
        |> Enum.join(" ")
      end
      Map.put(acc, psc.psc_code, "#{psc.psc_code} - #{name}")
    end)
  end
end
