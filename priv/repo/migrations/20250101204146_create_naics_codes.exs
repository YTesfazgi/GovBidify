defmodule GovBidify.Repo.Migrations.CreateNaicsCodes do
  use Ecto.Migration

  def change do
    create table(:naics_codes) do
      add :code, :string
      add :description, :string
    end
  end
end
