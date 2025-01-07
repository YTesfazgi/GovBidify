defmodule GovBidify.NAICS_Codes do
  alias GovBidify.Repo
  alias GovBidify.NAICS_Code

  def list_naics_codes do
    Repo.all(NAICS_Code)
    |> Enum.reduce(%{}, fn naics, acc ->
      Map.put(acc, naics.code, "#{naics.code} #{naics.description}")
    end)
  end
end
