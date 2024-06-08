defmodule GovBidify.Repo.Migrations.CreateSamOpportunities do
  use Ecto.Migration

  def change do
    create table(:sam_opportunities) do
      add :notice_id, :string
      add :title, :text
      add :sol, :string
      add :department_ind_agency, :string
      add :cgac, :string
      add :sub_tier, :string
      add :fpds_code, :string
      add :office, :string
      add :aac_code, :string
      add :posted_date, :string
      add :type, :string
      add :base_type, :string
      add :archive_type, :string
      add :archive_date, :string
      add :set_aside_code, :string
      add :set_aside, :string
      add :response_deadline, :string
      add :naics_code, :string
      add :classification_code, :string
      add :pop_street_address, :string
      add :pop_city, :string
      add :pop_state, :string
      add :pop_zip, :string
      add :pop_country, :string
      add :active, :string
      add :award_number, :string
      add :award_date, :string
      add :award, :string
      add :awardee, :string
      add :primary_contact_title, :string
      add :primary_contact_fullname, :text
      add :primary_contact_email, :string
      add :primary_contact_phone, :string
      add :primary_contact_fax, :string
      add :secondary_contact_title, :string
      add :secondary_contact_fullname, :text
      add :secondary_contact_email, :string
      add :secondary_contact_phone, :string
      add :secondary_contact_fax, :string
      add :organization_type, :string
      add :state, :string
      add :city, :string
      add :zip_code, :string
      add :country_code, :string
      add :additional_info_link, :string
      add :link, :string
      add :description, :text

    end
  end
end
