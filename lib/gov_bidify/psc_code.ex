defmodule GovBidify.PSC_Code do
  use Ecto.Schema
  import Ecto.Changeset

  schema "psc_codes" do
    field :psc_code, :string
    field :product_and_service_code_name, :string
    field :start_date, :date
    field :end_date, :date
    field :product_and_service_code_full_name, :string
    field :product_and_service_code_includes, :string
    field :product_and_service_code_excludes, :string
    field :product_and_service_notes, :string
    field :parent_psc_code, :string
    field :psc_category, :string
    field :level_1_category_code, :float
    field :level_1_category, :string
    field :level_2_category_code, :float
    field :level_2_category, :string
  end

  @doc false
  def changeset(psc_code, attrs) do
    psc_code
    |> cast(attrs, [:psc_code, :product_and_service_code_name, :start_date, :end_date, :product_and_service_code_full_name, :product_and_service_code_includes, :product_and_service_code_excludes, :product_and_service_notes, :parent_psc_code, :psc_category, :level_1_category_code, :level_1_category, :level_2_category_code, :level_2_category])
    |> validate_required([:psc_code])
  end
end
