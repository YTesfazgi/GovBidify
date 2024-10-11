defmodule GovBidify.Opportunities.Opportunity do
  use Ecto.Schema
  import Ecto.Changeset

  # @derive {
  #   Flop.Schema,
  #   filterable: [:title, :type, :department_ind_agency, :sub_tier, :office, :classification_code, :naics_code, :cgac, :set_aside, :aac_code, :pop_city, :pop_state, :pop_zip, :pop_country, :posted_date, :response_deadline, :active],
  #   sortable: [:title, :type, :department_ind_agency, :sub_tier, :office, :classification_code, :naics_code, :set_aside, :pop_city, :pop_state, :pop_zip, :pop_country, :posted_date, :response_deadline, :active]
  # }

  @derive {
    Flop.Schema,
    filterable: [:type, :naics_code, :cgac, :set_aside_code, :aac_code, :pop_city, :pop_state, :pop_zip, :pop_country, :department_ind_agency, :sub_tier, :office, :active],
    sortable: [:title, :response_deadline, :type, :naics_code, :cgac, :set_aside_code, :aac_code, :pop_city, :pop_state, :pop_zip, :pop_country, :department_ind_agency, :sub_tier, :office]
  }

  @primary_key {:notice_id, :string, []}
  schema "opportunities" do
    field :awardee, :string
    field :secondary_contact_phone, :string
    field :primary_contact_phone, :string
    field :department_ind_agency, :string # Department (L1)
    field :pop_zip, :string
    field :pop_state, :string
    field :cgac, :string # Common Government-wide Accounting Classification
    field :office, :string # Office (L3)
    field :pop_street_address, :string
    field :primary_contact_fax, :string
    field :pop_country, :string
    field :naics_code, :string # North American Industry Classification System
    field :sub_tier, :string # Sub-tier (L2)
    field :pop_city, :string
    field :primary_contact_fullname, :string
    field :award, :string # Monetary amount
    field :archive_date, :date
    field :active, :string
    field :set_aside_code, :string
    field :zip_code, :string
    field :organization_type, :string # Type of an organization -- department/sub-tier/office
    field :response_deadline, :utc_datetime
    field :aac_code, :string # Activity Address Code
    field :primary_contact_title, :string
    field :secondary_contact_fax, :string
    field :award_number, :string # Award ID
    field :link, :string # Direct link to SAM notice
    field :additional_info_link, :string
    field :secondary_contact_email, :string
    field :fpds_code, :string
    field :description, :string
    field :type, :string # Current opportunity type
    field :primary_contact_email, :string
    field :secondary_contact_fullname, :string
    field :title, :string
    field :posted_date, :date
    field :award_date, :date
    field :base_type, :string # Original opportunity type
    field :sol, :string # Solicitation ID
    field :city, :string
    field :classification_code, :string
    field :archive_type, :string
    field :secondary_contact_title, :string
    field :set_aside, :string # Description of set aside
    field :state, :string
    field :country_code, :string

  end

  @doc false
  def changeset(opportunity, attrs) do
    opportunity
    |> cast(
      attrs,
      [
        :notice_id,
        :title,
        :sol,
        :department_ind_agency,
        :cgac,
        :sub_tier,
        :fpds_code,
        :office,
        :aac_code,
        :posted_date,
        :type,
        :base_type,
        :archive_type,
        :archive_date,
        :set_aside_code,
        :set_aside,
        :response_deadline,
        :naics_code,
        :classification_code,
        :pop_street_address,
        :pop_city,
        :pop_state,
        :pop_zip,
        :pop_country,
        :active,
        :award_number,
        :award_date,
        :award,
        :awardee,
        :primary_contact_title,
        :primary_contact_fullname,
        :primary_contact_email,
        :primary_contact_phone,
        :primary_contact_fax,
        :secondary_contact_title,
        :secondary_contact_fullname,
        :secondary_contact_email,
        :secondary_contact_phone,
        :secondary_contact_fax,
        :organization_type,
        :state,
        :city,
        :zip_code,
        :country_code,
        :additional_info_link,
        :link,
        :description
      ])
    |> validate_required(
      [
        :notice_id,
        :title,
        :sol,
        :department_ind_agency,
        :cgac,
        :sub_tier,
        :fpds_code,
        :office,
        :aac_code,
        :posted_date,
        :type,
        :base_type,
        :archive_type,
        :archive_date,
        :set_aside_code,
        :set_aside,
        :response_deadline,
        :naics_code,
        :classification_code,
        :pop_street_address,
        :pop_city,
        :pop_state,
        :pop_zip,
        :pop_country,
        :active,
        :award_number,
        :award_date,
        :award,
        :awardee,
        :primary_contact_title,
        :primary_contact_fullname,
        :primary_contact_email,
        :primary_contact_phone,
        :primary_contact_fax,
        :secondary_contact_title,
        :secondary_contact_fullname,
        :secondary_contact_email,
        :secondary_contact_phone,
        :secondary_contact_fax,
        :organization_type,
        :state,
        :city,
        :zip_code,
        :country_code,
        :additional_info_link,
        :link,
        :description
      ])
  end
end
