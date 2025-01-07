defmodule GovBidify.Repo.Migrations.CreatePscCodes do
  use Ecto.Migration

  def change do
    create table(:psc_codes) do
      add :psc_code, :string
      add :product_and_service_code_name, :string
      add :start_date, :date
      add :end_date, :date
      add :product_and_service_code_full_name, :text
      add :product_and_service_code_includes, :text
      add :product_and_service_code_excludes, :text
      add :product_and_service_notes, :text
      add :parent_psc_code, :string
      add :psc_category, :string
      add :level_1_category_code, :float
      add :level_1_category, :string
      add :level_2_category_code, :float
      add :level_2_category, :string
    end
  end
end
