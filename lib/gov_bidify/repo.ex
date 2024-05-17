defmodule GovBidify.Repo do
  use Ecto.Repo,
    otp_app: :gov_bidify,
    adapter: Ecto.Adapters.Postgres
end
