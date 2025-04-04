defmodule GovBidify.Entities.Entity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entities" do
    field :unique_entity_id, :string
    field :govt_bus_poc_us_phone_ext, :string
    field :past_perf_poc_state_or_province, :string
    field :naics_code_string, :string
    field :alt_govt_bus_poc_us_phone_ext, :string
    field :alt_govt_bus_poc_st_add_1, :string
    field :blank_deprecated, :string
    field :past_perf_poc_poc_last_name, :string
    field :govt_bus_poc_city, :string
    field :state_of_incorporation, :string
    field :physical_address_line_2, :string
    field :highest_employee_security_level, :string
    field :govt_bus_poc_st_add_1, :string
    field :company_security_level, :string
    field :physical_address_line_1, :string
    field :alt_govt_bus_poc_us_phone, :string
    field :cage_code, :string
    field :purpose_of_registration, :string
    field :govt_bus_poc_us_phone, :string
    field :alt_govt_bus_poc_zip_postal_code, :string
    field :alt_govt_bus_poc_middle_initial, :string
    field :alt_govt_bus_poc_title, :string
    field :govt_bus_poc_first_name, :string
    field :govt_bus_poc_middle_initial, :string
    field :psc_code_counter, :string
    field :entity_url, :string
    field :past_perf_poc_zip_postal_code, :string
    field :last_update_date, :date
    field :mailing_address_city, :string
    field :alt_past_perf_poc_last_name, :string
    field :country_of_incorporation, :string
    field :d_b_open_data_flag, :string
    field :govt_bus_poc_non_us_phone, :string
    field :alt_govt_bus_poc_non_us_phone, :string
    field :business_type_counter, :string
    field :govt_bus_poc_title, :string
    field :mailing_address_line_1, :string
    field :past_perf_poc_non_us_phone, :string
    field :alt_govt_bus_poc_city, :string
    field :alt_govt_bus_poc_state_or_province, :string
    field :alt_govt_bus_poc_email, :string
    field :govt_bus_poc_email, :string
    field :past_perf_poc_fax_us_only, :string
    field :past_perf_poc_zip_code_4, :string
    field :alt_govt_bus_poc_st_add_2, :string
    field :alt_past_perf_poc_city, :string
    field :physical_address_country_code, :string
    field :entity_division_number, :string
    field :naics_code_counter, :string
    field :govt_bus_poc_last_name, :string
    field :govt_bus_poc_fax_us_only, :string
    field :physical_address_zip_postal_code, :string
    field :alt_govt_bus_poc_first_name, :string
    field :registration_expiration_date, :date
    field :entity_division_name, :string
    field :agency_business_purpose, :string
    field :activation_date, :date
    field :past_perf_poc_poc_title, :string
    field :alt_govt_bus_poc_fax_us_only, :string
    field :entity_structure, :string
    field :entity_start_date, :date
    field :mailing_address_zip_code_4, :string
    field :alt_govt_bus_poc_last_name, :string
    field :mailing_address_country, :string
    field :govt_bus_poc_zip_code_4, :string
    field :alt_past_perf_poc_title, :string
    field :past_perf_poc_country_code, :string
    field :alt_govt_bus_poc_zip_code_4, :string
    field :past_perf_poc_st_add_1, :string
    field :govt_bus_poc_st_add_2, :string
    field :govt_bus_poc_zip_postal_code, :string
    field :past_perf_poc_poc_middle_initial, :string
    field :past_perf_poc_st_add_2, :string
    field :correspondence_flag, :string
    field :fiscal_year_end_close_date, :date
    field :physical_address_city, :string
    field :past_perf_poc_us_phone, :string
    field :past_perf_poc_us_phone_ext, :string
    field :govt_bus_poc_country_code, :string
    field :past_perf_poc_poc_first_name, :string
    field :alt_past_perf_poc_st_add_1, :string
    field :bus_type_string, :string
    field :physical_address_province_or_state, :string
    field :mailing_address_zip_postal_code, :string
    field :dba_name, :string
    field :past_perf_poc_email, :string
    field :primary_naics, :string
    field :dodaac, :string
    field :alt_past_perf_poc_middle_initial, :string
    field :psc_code_string, :string
    field :alt_past_perf_poc_st_add_2, :string
    field :entity_eft_indicator, :string
    field :alt_govt_bus_poc_country_code, :string
    field :credit_card_usage, :string
    field :legal_business_name, :string
    field :mailing_address_line_2, :string
    field :mailing_address_state_or_province, :string
    field :past_perf_poc_city, :string
    field :physical_address_congressional_district, :string
    field :physical_address_zip_code_4, :string
    field :initial_registration_date, :date
    field :govt_bus_poc_state_or_province, :string
    field :sam_extract_code, :string
    field :alt_past_perf_poc_first_name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:unique_entity_id, :blank_deprecated, :entity_eft_indicator, :cage_code, :dodaac, :sam_extract_code, :purpose_of_registration, :initial_registration_date, :registration_expiration_date, :last_update_date, :activation_date, :legal_business_name, :dba_name, :entity_division_name, :entity_division_number, :physical_address_line_1, :physical_address_line_2, :physical_address_city, :physical_address_province_or_state, :physical_address_zip_postal_code, :physical_address_zip_code_4, :physical_address_country_code, :physical_address_congressional_district, :d_b_open_data_flag, :entity_start_date, :fiscal_year_end_close_date, :company_security_level, :highest_employee_security_level, :entity_url, :entity_structure, :state_of_incorporation, :country_of_incorporation, :business_type_counter, :bus_type_string, :agency_business_purpose, :primary_naics, :naics_code_counter, :naics_code_string, :psc_code_counter, :psc_code_string, :credit_card_usage, :correspondence_flag, :mailing_address_line_1, :mailing_address_line_2, :mailing_address_city, :mailing_address_zip_postal_code, :mailing_address_zip_code_4, :mailing_address_country, :mailing_address_state_or_province, :govt_bus_poc_first_name, :govt_bus_poc_middle_initial, :govt_bus_poc_last_name, :govt_bus_poc_title, :govt_bus_poc_st_add_1, :govt_bus_poc_st_add_2, :govt_bus_poc_city, :govt_bus_poc_zip_postal_code, :govt_bus_poc_zip_code_4, :govt_bus_poc_country_code, :govt_bus_poc_state_or_province, :govt_bus_poc_us_phone, :govt_bus_poc_us_phone_ext, :govt_bus_poc_non_us_phone, :govt_bus_poc_fax_us_only, :govt_bus_poc_email, :alt_govt_bus_poc_first_name, :alt_govt_bus_poc_middle_initial, :alt_govt_bus_poc_last_name, :alt_govt_bus_poc_title, :alt_govt_bus_poc_st_add_1, :alt_govt_bus_poc_st_add_2, :alt_govt_bus_poc_city, :alt_govt_bus_poc_zip_postal_code, :alt_govt_bus_poc_zip_code_4, :alt_govt_bus_poc_country_code, :alt_govt_bus_poc_state_or_province, :alt_govt_bus_poc_us_phone, :alt_govt_bus_poc_us_phone_ext, :alt_govt_bus_poc_non_us_phone, :alt_govt_bus_poc_fax_us_only, :alt_govt_bus_poc_email, :past_perf_poc_poc_first_name, :past_perf_poc_poc_middle_initial, :past_perf_poc_poc_last_name, :past_perf_poc_poc_title, :past_perf_poc_st_add_1, :past_perf_poc_st_add_2, :past_perf_poc_city, :past_perf_poc_zip_postal_code, :past_perf_poc_zip_code_4, :past_perf_poc_country_code, :past_perf_poc_state_or_province, :past_perf_poc_us_phone, :past_perf_poc_us_phone_ext, :past_perf_poc_non_us_phone, :past_perf_poc_fax_us_only, :past_perf_poc_email, :alt_past_perf_poc_first_name, :alt_past_perf_poc_middle_initial, :alt_past_perf_poc_last_name, :alt_past_perf_poc_title, :alt_past_perf_poc_st_add_1, :alt_past_perf_poc_st_add_2, :alt_past_perf_poc_city])
    |> validate_required([:unique_entity_id])
  end
end
