defmodule GovBidify.NAICSCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "naics_codes" do
    field :code, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(naics_codes, attrs) do
    naics_codes
    |> cast(attrs, [:code, :description])
    |> validate_required([:code, :description])
  end
end
