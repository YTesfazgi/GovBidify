defmodule GovBidify.Repo.Migrations.CreateOpportunities do
  use Ecto.Migration

  def change do
    create table(:opportunities, primary_key: false) do
      add :notice_id, :string, primary_key: true
      add :title, :text
      add :sol, :string
      add :department_ind_agency, :string
      add :cgac, :string
      add :sub_tier, :string
      add :fpds_code, :string
      add :office, :string
      add :aac_code, :string
      add :posted_date, :date
      add :type, :string
      add :base_type, :string
      add :archive_type, :string
      add :archive_date, :date
      add :set_aside_code, :string
      add :set_aside, :string
      add :response_deadline, :utc_datetime
      add :naics_code, :string
      add :classification_code, :string
      add :pop_street_address, :text
      add :pop_city, :string
      add :pop_state, :string
      add :pop_zip, :string
      add :pop_country, :string
      add :active, :string
      add :award_number, :string
      add :award_date, :date
      add :award, :string
      add :awardee, :text
      add :primary_contact_title, :text
      add :primary_contact_fullname, :text
      add :primary_contact_email, :string
      add :primary_contact_phone, :string
      add :primary_contact_fax, :string
      add :secondary_contact_title, :text
      add :secondary_contact_fullname, :text
      add :secondary_contact_email, :string
      add :secondary_contact_phone, :string
      add :secondary_contact_fax, :string
      add :organization_type, :string
      add :state, :string
      add :city, :string
      add :zip_code, :string
      add :country_code, :string
      add :additional_info_link, :text
      add :link, :text
      add :description, :text

    end
  end
end
