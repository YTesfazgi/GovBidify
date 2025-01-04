defmodule GovBidify.NAICSCodes do
  alias GovBidify.Repo
  alias GovBidify.NAICSCode

  def list_naics_codes do
    Repo.all(NAICSCode)
    |> Enum.reduce(%{}, fn naics, acc ->
      Map.put(acc, naics.code, "#{naics.code} #{naics.description}")
    end)
  end
end
