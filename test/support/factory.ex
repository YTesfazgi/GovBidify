defmodule GovBidify.Factory do
  use ExMachina.Ecto, repo: GovBidify.Repo

  use GovBidify.Opportunities.OpportunityFactory
end
