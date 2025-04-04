defmodule GovBidify.EntitiesTest do
  use GovBidify.DataCase

  alias GovBidify.Entities

  describe "entities" do
    alias GovBidify.Entities.Entity

    import GovBidify.EntitiesFixtures

    @invalid_attrs %{alt_past_perf_poc_first_name: nil, sam_extract_code: nil, govt_bus_poc_state_or_province: nil, initial_registration_date: nil, physical_address_zip_code_4: nil, physical_address_congressional_district: nil, past_perf_poc_city: nil, mailing_address_state_or_province: nil, mailing_address_line_2: nil, legal_business_name: nil, credit_card_usage: nil, alt_govt_bus_poc_country_code: nil, entity_eft_indicator: nil, alt_past_perf_poc_st_add_2: nil, psc_code_string: nil, alt_past_perf_poc_middle_initial: nil, dodaac: nil, primary_naics: nil, past_perf_poc_email: nil, dba_name: nil, mailing_address_zip_postal_code: nil, physical_address_province_or_state: nil, bus_type_string: nil, alt_past_perf_poc_st_add_1: nil, past_perf_poc_poc_first_name: nil, govt_bus_poc_country_code: nil, past_perf_poc_us_phone_ext: nil, past_perf_poc_us_phone: nil, physical_address_city: nil, fiscal_year_end_close_date: nil, correspondence_flag: nil, past_perf_poc_st_add_2: nil, past_perf_poc_poc_middle_initial: nil, govt_bus_poc_zip_postal_code: nil, govt_bus_poc_st_add_2: nil, past_perf_poc_st_add_1: nil, alt_govt_bus_poc_zip_code_4: nil, past_perf_poc_country_code: nil, alt_past_perf_poc_title: nil, govt_bus_poc_zip_code_4: nil, mailing_address_country: nil, alt_govt_bus_poc_last_name: nil, mailing_address_zip_code_4: nil, entity_start_date: nil, entity_structure: nil, alt_govt_bus_poc_fax_us_only: nil, past_perf_poc_poc_title: nil, activation_date: nil, agency_business_purpose: nil, entity_division_name: nil, registration_expiration_date: nil, alt_govt_bus_poc_first_name: nil, unique_entity_id: nil, physical_address_zip_postal_code: nil, govt_bus_poc_fax_us_only: nil, govt_bus_poc_last_name: nil, naics_code_counter: nil, entity_division_number: nil, physical_address_country_code: nil, alt_past_perf_poc_city: nil, alt_govt_bus_poc_st_add_2: nil, past_perf_poc_zip_code_4: nil, past_perf_poc_fax_us_only: nil, govt_bus_poc_email: nil, alt_govt_bus_poc_email: nil, alt_govt_bus_poc_state_or_province: nil, alt_govt_bus_poc_city: nil, past_perf_poc_non_us_phone: nil, mailing_address_line_1: nil, govt_bus_poc_title: nil, business_type_counter: nil, alt_govt_bus_poc_non_us_phone: nil, govt_bus_poc_non_us_phone: nil, d_b_open_data_flag: nil, country_of_incorporation: nil, alt_past_perf_poc_last_name: nil, mailing_address_city: nil, last_update_date: nil, past_perf_poc_zip_postal_code: nil, entity_url: nil, psc_code_counter: nil, govt_bus_poc_middle_initial: nil, govt_bus_poc_first_name: nil, alt_govt_bus_poc_title: nil, alt_govt_bus_poc_middle_initial: nil, alt_govt_bus_poc_zip_postal_code: nil, govt_bus_poc_us_phone: nil, purpose_of_registration: nil, cage_code: nil, alt_govt_bus_poc_us_phone: nil, physical_address_line_1: nil, company_security_level: nil, govt_bus_poc_st_add_1: nil, highest_employee_security_level: nil, physical_address_line_2: nil, state_of_incorporation: nil, govt_bus_poc_city: nil, past_perf_poc_poc_last_name: nil, blank_deprecated: nil, alt_govt_bus_poc_st_add_1: nil, alt_govt_bus_poc_us_phone_ext: nil, naics_code_string: nil, past_perf_poc_state_or_province: nil, govt_bus_poc_us_phone_ext: nil}

    test "list_entities/0 returns all entities" do
      entity = entity_fixture()
      assert Entities.list_entities() == [entity]
    end

    test "get_entity!/1 returns the entity with given id" do
      entity = entity_fixture()
      assert Entities.get_entity!(entity.id) == entity
    end

    test "create_entity/1 with valid data creates a entity" do
      valid_attrs = %{alt_past_perf_poc_first_name: "some alt_past_perf_poc_first_name", sam_extract_code: "some sam_extract_code", govt_bus_poc_state_or_province: "some govt_bus_poc_state_or_province", initial_registration_date: ~D[2025-04-01], physical_address_zip_code_4: "some physical_address_zip_code_4", physical_address_congressional_district: "some physical_address_congressional_district", past_perf_poc_city: "some past_perf_poc_city", mailing_address_state_or_province: "some mailing_address_state_or_province", mailing_address_line_2: "some mailing_address_line_2", legal_business_name: "some legal_business_name", credit_card_usage: "some credit_card_usage", alt_govt_bus_poc_country_code: "some alt_govt_bus_poc_country_code", entity_eft_indicator: "some entity_eft_indicator", alt_past_perf_poc_st_add_2: "some alt_past_perf_poc_st_add_2", psc_code_string: "some psc_code_string", alt_past_perf_poc_middle_initial: "some alt_past_perf_poc_middle_initial", dodaac: "some dodaac", primary_naics: "some primary_naics", past_perf_poc_email: "some past_perf_poc_email", dba_name: "some dba_name", mailing_address_zip_postal_code: "some mailing_address_zip_postal_code", physical_address_province_or_state: "some physical_address_province_or_state", bus_type_string: "some bus_type_string", alt_past_perf_poc_st_add_1: "some alt_past_perf_poc_st_add_1", past_perf_poc_poc_first_name: "some past_perf_poc_poc_first_name", govt_bus_poc_country_code: "some govt_bus_poc_country_code", past_perf_poc_us_phone_ext: "some past_perf_poc_us_phone_ext", past_perf_poc_us_phone: "some past_perf_poc_us_phone", physical_address_city: "some physical_address_city", fiscal_year_end_close_date: ~D[2025-04-01], correspondence_flag: "some correspondence_flag", past_perf_poc_st_add_2: "some past_perf_poc_st_add_2", past_perf_poc_poc_middle_initial: "some past_perf_poc_poc_middle_initial", govt_bus_poc_zip_postal_code: "some govt_bus_poc_zip_postal_code", govt_bus_poc_st_add_2: "some govt_bus_poc_st_add_2", past_perf_poc_st_add_1: "some past_perf_poc_st_add_1", alt_govt_bus_poc_zip_code_4: "some alt_govt_bus_poc_zip_code_4", past_perf_poc_country_code: "some past_perf_poc_country_code", alt_past_perf_poc_title: "some alt_past_perf_poc_title", govt_bus_poc_zip_code_4: "some govt_bus_poc_zip_code_4", mailing_address_country: "some mailing_address_country", alt_govt_bus_poc_last_name: "some alt_govt_bus_poc_last_name", mailing_address_zip_code_4: "some mailing_address_zip_code_4", entity_start_date: ~D[2025-04-01], entity_structure: "some entity_structure", alt_govt_bus_poc_fax_us_only: "some alt_govt_bus_poc_fax_us_only", past_perf_poc_poc_title: "some past_perf_poc_poc_title", activation_date: ~D[2025-04-01], agency_business_purpose: "some agency_business_purpose", entity_division_name: "some entity_division_name", registration_expiration_date: ~D[2025-04-01], alt_govt_bus_poc_first_name: "some alt_govt_bus_poc_first_name", unique_entity_id: "some unique_entity_id", physical_address_zip_postal_code: "some physical_address_zip_postal_code", govt_bus_poc_fax_us_only: "some govt_bus_poc_fax_us_only", govt_bus_poc_last_name: "some govt_bus_poc_last_name", naics_code_counter: "some naics_code_counter", entity_division_number: "some entity_division_number", physical_address_country_code: "some physical_address_country_code", alt_past_perf_poc_city: "some alt_past_perf_poc_city", alt_govt_bus_poc_st_add_2: "some alt_govt_bus_poc_st_add_2", past_perf_poc_zip_code_4: "some past_perf_poc_zip_code_4", past_perf_poc_fax_us_only: "some past_perf_poc_fax_us_only", govt_bus_poc_email: "some govt_bus_poc_email", alt_govt_bus_poc_email: "some alt_govt_bus_poc_email", alt_govt_bus_poc_state_or_province: "some alt_govt_bus_poc_state_or_province", alt_govt_bus_poc_city: "some alt_govt_bus_poc_city", past_perf_poc_non_us_phone: "some past_perf_poc_non_us_phone", mailing_address_line_1: "some mailing_address_line_1", govt_bus_poc_title: "some govt_bus_poc_title", business_type_counter: "some business_type_counter", alt_govt_bus_poc_non_us_phone: "some alt_govt_bus_poc_non_us_phone", govt_bus_poc_non_us_phone: "some govt_bus_poc_non_us_phone", d_b_open_data_flag: "some d_b_open_data_flag", country_of_incorporation: "some country_of_incorporation", alt_past_perf_poc_last_name: "some alt_past_perf_poc_last_name", mailing_address_city: "some mailing_address_city", last_update_date: ~D[2025-04-01], past_perf_poc_zip_postal_code: "some past_perf_poc_zip_postal_code", entity_url: "some entity_url", psc_code_counter: "some psc_code_counter", govt_bus_poc_middle_initial: "some govt_bus_poc_middle_initial", govt_bus_poc_first_name: "some govt_bus_poc_first_name", alt_govt_bus_poc_title: "some alt_govt_bus_poc_title", alt_govt_bus_poc_middle_initial: "some alt_govt_bus_poc_middle_initial", alt_govt_bus_poc_zip_postal_code: "some alt_govt_bus_poc_zip_postal_code", govt_bus_poc_us_phone: "some govt_bus_poc_us_phone", purpose_of_registration: "some purpose_of_registration", cage_code: "some cage_code", alt_govt_bus_poc_us_phone: "some alt_govt_bus_poc_us_phone", physical_address_line_1: "some physical_address_line_1", company_security_level: "some company_security_level", govt_bus_poc_st_add_1: "some govt_bus_poc_st_add_1", highest_employee_security_level: "some highest_employee_security_level", physical_address_line_2: "some physical_address_line_2", state_of_incorporation: "some state_of_incorporation", govt_bus_poc_city: "some govt_bus_poc_city", past_perf_poc_poc_last_name: "some past_perf_poc_poc_last_name", blank_deprecated: "some blank_deprecated", alt_govt_bus_poc_st_add_1: "some alt_govt_bus_poc_st_add_1", alt_govt_bus_poc_us_phone_ext: "some alt_govt_bus_poc_us_phone_ext", naics_code_string: "some naics_code_string", past_perf_poc_state_or_province: "some past_perf_poc_state_or_province", govt_bus_poc_us_phone_ext: "some govt_bus_poc_us_phone_ext"}

      assert {:ok, %Entity{} = entity} = Entities.create_entity(valid_attrs)
      assert entity.govt_bus_poc_us_phone_ext == "some govt_bus_poc_us_phone_ext"
      assert entity.past_perf_poc_state_or_province == "some past_perf_poc_state_or_province"
      assert entity.naics_code_string == "some naics_code_string"
      assert entity.alt_govt_bus_poc_us_phone_ext == "some alt_govt_bus_poc_us_phone_ext"
      assert entity.alt_govt_bus_poc_st_add_1 == "some alt_govt_bus_poc_st_add_1"
      assert entity.blank_deprecated == "some blank_deprecated"
      assert entity.past_perf_poc_poc_last_name == "some past_perf_poc_poc_last_name"
      assert entity.govt_bus_poc_city == "some govt_bus_poc_city"
      assert entity.state_of_incorporation == "some state_of_incorporation"
      assert entity.physical_address_line_2 == "some physical_address_line_2"
      assert entity.highest_employee_security_level == "some highest_employee_security_level"
      assert entity.govt_bus_poc_st_add_1 == "some govt_bus_poc_st_add_1"
      assert entity.company_security_level == "some company_security_level"
      assert entity.physical_address_line_1 == "some physical_address_line_1"
      assert entity.alt_govt_bus_poc_us_phone == "some alt_govt_bus_poc_us_phone"
      assert entity.cage_code == "some cage_code"
      assert entity.purpose_of_registration == "some purpose_of_registration"
      assert entity.govt_bus_poc_us_phone == "some govt_bus_poc_us_phone"
      assert entity.alt_govt_bus_poc_zip_postal_code == "some alt_govt_bus_poc_zip_postal_code"
      assert entity.alt_govt_bus_poc_middle_initial == "some alt_govt_bus_poc_middle_initial"
      assert entity.alt_govt_bus_poc_title == "some alt_govt_bus_poc_title"
      assert entity.govt_bus_poc_first_name == "some govt_bus_poc_first_name"
      assert entity.govt_bus_poc_middle_initial == "some govt_bus_poc_middle_initial"
      assert entity.psc_code_counter == "some psc_code_counter"
      assert entity.entity_url == "some entity_url"
      assert entity.past_perf_poc_zip_postal_code == "some past_perf_poc_zip_postal_code"
      assert entity.last_update_date == ~D[2025-04-01]
      assert entity.mailing_address_city == "some mailing_address_city"
      assert entity.alt_past_perf_poc_last_name == "some alt_past_perf_poc_last_name"
      assert entity.country_of_incorporation == "some country_of_incorporation"
      assert entity.d_b_open_data_flag == "some d_b_open_data_flag"
      assert entity.govt_bus_poc_non_us_phone == "some govt_bus_poc_non_us_phone"
      assert entity.alt_govt_bus_poc_non_us_phone == "some alt_govt_bus_poc_non_us_phone"
      assert entity.business_type_counter == "some business_type_counter"
      assert entity.govt_bus_poc_title == "some govt_bus_poc_title"
      assert entity.mailing_address_line_1 == "some mailing_address_line_1"
      assert entity.past_perf_poc_non_us_phone == "some past_perf_poc_non_us_phone"
      assert entity.alt_govt_bus_poc_city == "some alt_govt_bus_poc_city"
      assert entity.alt_govt_bus_poc_state_or_province == "some alt_govt_bus_poc_state_or_province"
      assert entity.alt_govt_bus_poc_email == "some alt_govt_bus_poc_email"
      assert entity.govt_bus_poc_email == "some govt_bus_poc_email"
      assert entity.past_perf_poc_fax_us_only == "some past_perf_poc_fax_us_only"
      assert entity.past_perf_poc_zip_code_4 == "some past_perf_poc_zip_code_4"
      assert entity.alt_govt_bus_poc_st_add_2 == "some alt_govt_bus_poc_st_add_2"
      assert entity.alt_past_perf_poc_city == "some alt_past_perf_poc_city"
      assert entity.physical_address_country_code == "some physical_address_country_code"
      assert entity.entity_division_number == "some entity_division_number"
      assert entity.naics_code_counter == "some naics_code_counter"
      assert entity.govt_bus_poc_last_name == "some govt_bus_poc_last_name"
      assert entity.govt_bus_poc_fax_us_only == "some govt_bus_poc_fax_us_only"
      assert entity.physical_address_zip_postal_code == "some physical_address_zip_postal_code"
      assert entity.unique_entity_id == "some unique_entity_id"
      assert entity.alt_govt_bus_poc_first_name == "some alt_govt_bus_poc_first_name"
      assert entity.registration_expiration_date == ~D[2025-04-01]
      assert entity.entity_division_name == "some entity_division_name"
      assert entity.agency_business_purpose == "some agency_business_purpose"
      assert entity.activation_date == ~D[2025-04-01]
      assert entity.past_perf_poc_poc_title == "some past_perf_poc_poc_title"
      assert entity.alt_govt_bus_poc_fax_us_only == "some alt_govt_bus_poc_fax_us_only"
      assert entity.entity_structure == "some entity_structure"
      assert entity.entity_start_date == ~D[2025-04-01]
      assert entity.mailing_address_zip_code_4 == "some mailing_address_zip_code_4"
      assert entity.alt_govt_bus_poc_last_name == "some alt_govt_bus_poc_last_name"
      assert entity.mailing_address_country == "some mailing_address_country"
      assert entity.govt_bus_poc_zip_code_4 == "some govt_bus_poc_zip_code_4"
      assert entity.alt_past_perf_poc_title == "some alt_past_perf_poc_title"
      assert entity.past_perf_poc_country_code == "some past_perf_poc_country_code"
      assert entity.alt_govt_bus_poc_zip_code_4 == "some alt_govt_bus_poc_zip_code_4"
      assert entity.past_perf_poc_st_add_1 == "some past_perf_poc_st_add_1"
      assert entity.govt_bus_poc_st_add_2 == "some govt_bus_poc_st_add_2"
      assert entity.govt_bus_poc_zip_postal_code == "some govt_bus_poc_zip_postal_code"
      assert entity.past_perf_poc_poc_middle_initial == "some past_perf_poc_poc_middle_initial"
      assert entity.past_perf_poc_st_add_2 == "some past_perf_poc_st_add_2"
      assert entity.correspondence_flag == "some correspondence_flag"
      assert entity.fiscal_year_end_close_date == ~D[2025-04-01]
      assert entity.physical_address_city == "some physical_address_city"
      assert entity.past_perf_poc_us_phone == "some past_perf_poc_us_phone"
      assert entity.past_perf_poc_us_phone_ext == "some past_perf_poc_us_phone_ext"
      assert entity.govt_bus_poc_country_code == "some govt_bus_poc_country_code"
      assert entity.past_perf_poc_poc_first_name == "some past_perf_poc_poc_first_name"
      assert entity.alt_past_perf_poc_st_add_1 == "some alt_past_perf_poc_st_add_1"
      assert entity.bus_type_string == "some bus_type_string"
      assert entity.physical_address_province_or_state == "some physical_address_province_or_state"
      assert entity.mailing_address_zip_postal_code == "some mailing_address_zip_postal_code"
      assert entity.dba_name == "some dba_name"
      assert entity.past_perf_poc_email == "some past_perf_poc_email"
      assert entity.primary_naics == "some primary_naics"
      assert entity.dodaac == "some dodaac"
      assert entity.alt_past_perf_poc_middle_initial == "some alt_past_perf_poc_middle_initial"
      assert entity.psc_code_string == "some psc_code_string"
      assert entity.alt_past_perf_poc_st_add_2 == "some alt_past_perf_poc_st_add_2"
      assert entity.entity_eft_indicator == "some entity_eft_indicator"
      assert entity.alt_govt_bus_poc_country_code == "some alt_govt_bus_poc_country_code"
      assert entity.credit_card_usage == "some credit_card_usage"
      assert entity.legal_business_name == "some legal_business_name"
      assert entity.mailing_address_line_2 == "some mailing_address_line_2"
      assert entity.mailing_address_state_or_province == "some mailing_address_state_or_province"
      assert entity.past_perf_poc_city == "some past_perf_poc_city"
      assert entity.physical_address_congressional_district == "some physical_address_congressional_district"
      assert entity.physical_address_zip_code_4 == "some physical_address_zip_code_4"
      assert entity.initial_registration_date == ~D[2025-04-01]
      assert entity.govt_bus_poc_state_or_province == "some govt_bus_poc_state_or_province"
      assert entity.sam_extract_code == "some sam_extract_code"
      assert entity.alt_past_perf_poc_first_name == "some alt_past_perf_poc_first_name"
    end

    test "create_entity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_entity(@invalid_attrs)
    end

    test "update_entity/2 with valid data updates the entity" do
      entity = entity_fixture()
      update_attrs = %{alt_past_perf_poc_first_name: "some updated alt_past_perf_poc_first_name", sam_extract_code: "some updated sam_extract_code", govt_bus_poc_state_or_province: "some updated govt_bus_poc_state_or_province", initial_registration_date: ~D[2025-04-02], physical_address_zip_code_4: "some updated physical_address_zip_code_4", physical_address_congressional_district: "some updated physical_address_congressional_district", past_perf_poc_city: "some updated past_perf_poc_city", mailing_address_state_or_province: "some updated mailing_address_state_or_province", mailing_address_line_2: "some updated mailing_address_line_2", legal_business_name: "some updated legal_business_name", credit_card_usage: "some updated credit_card_usage", alt_govt_bus_poc_country_code: "some updated alt_govt_bus_poc_country_code", entity_eft_indicator: "some updated entity_eft_indicator", alt_past_perf_poc_st_add_2: "some updated alt_past_perf_poc_st_add_2", psc_code_string: "some updated psc_code_string", alt_past_perf_poc_middle_initial: "some updated alt_past_perf_poc_middle_initial", dodaac: "some updated dodaac", primary_naics: "some updated primary_naics", past_perf_poc_email: "some updated past_perf_poc_email", dba_name: "some updated dba_name", mailing_address_zip_postal_code: "some updated mailing_address_zip_postal_code", physical_address_province_or_state: "some updated physical_address_province_or_state", bus_type_string: "some updated bus_type_string", alt_past_perf_poc_st_add_1: "some updated alt_past_perf_poc_st_add_1", past_perf_poc_poc_first_name: "some updated past_perf_poc_poc_first_name", govt_bus_poc_country_code: "some updated govt_bus_poc_country_code", past_perf_poc_us_phone_ext: "some updated past_perf_poc_us_phone_ext", past_perf_poc_us_phone: "some updated past_perf_poc_us_phone", physical_address_city: "some updated physical_address_city", fiscal_year_end_close_date: ~D[2025-04-02], correspondence_flag: "some updated correspondence_flag", past_perf_poc_st_add_2: "some updated past_perf_poc_st_add_2", past_perf_poc_poc_middle_initial: "some updated past_perf_poc_poc_middle_initial", govt_bus_poc_zip_postal_code: "some updated govt_bus_poc_zip_postal_code", govt_bus_poc_st_add_2: "some updated govt_bus_poc_st_add_2", past_perf_poc_st_add_1: "some updated past_perf_poc_st_add_1", alt_govt_bus_poc_zip_code_4: "some updated alt_govt_bus_poc_zip_code_4", past_perf_poc_country_code: "some updated past_perf_poc_country_code", alt_past_perf_poc_title: "some updated alt_past_perf_poc_title", govt_bus_poc_zip_code_4: "some updated govt_bus_poc_zip_code_4", mailing_address_country: "some updated mailing_address_country", alt_govt_bus_poc_last_name: "some updated alt_govt_bus_poc_last_name", mailing_address_zip_code_4: "some updated mailing_address_zip_code_4", entity_start_date: ~D[2025-04-02], entity_structure: "some updated entity_structure", alt_govt_bus_poc_fax_us_only: "some updated alt_govt_bus_poc_fax_us_only", past_perf_poc_poc_title: "some updated past_perf_poc_poc_title", activation_date: ~D[2025-04-02], agency_business_purpose: "some updated agency_business_purpose", entity_division_name: "some updated entity_division_name", registration_expiration_date: ~D[2025-04-02], alt_govt_bus_poc_first_name: "some updated alt_govt_bus_poc_first_name", unique_entity_id: "some updated unique_entity_id", physical_address_zip_postal_code: "some updated physical_address_zip_postal_code", govt_bus_poc_fax_us_only: "some updated govt_bus_poc_fax_us_only", govt_bus_poc_last_name: "some updated govt_bus_poc_last_name", naics_code_counter: "some updated naics_code_counter", entity_division_number: "some updated entity_division_number", physical_address_country_code: "some updated physical_address_country_code", alt_past_perf_poc_city: "some updated alt_past_perf_poc_city", alt_govt_bus_poc_st_add_2: "some updated alt_govt_bus_poc_st_add_2", past_perf_poc_zip_code_4: "some updated past_perf_poc_zip_code_4", past_perf_poc_fax_us_only: "some updated past_perf_poc_fax_us_only", govt_bus_poc_email: "some updated govt_bus_poc_email", alt_govt_bus_poc_email: "some updated alt_govt_bus_poc_email", alt_govt_bus_poc_state_or_province: "some updated alt_govt_bus_poc_state_or_province", alt_govt_bus_poc_city: "some updated alt_govt_bus_poc_city", past_perf_poc_non_us_phone: "some updated past_perf_poc_non_us_phone", mailing_address_line_1: "some updated mailing_address_line_1", govt_bus_poc_title: "some updated govt_bus_poc_title", business_type_counter: "some updated business_type_counter", alt_govt_bus_poc_non_us_phone: "some updated alt_govt_bus_poc_non_us_phone", govt_bus_poc_non_us_phone: "some updated govt_bus_poc_non_us_phone", d_b_open_data_flag: "some updated d_b_open_data_flag", country_of_incorporation: "some updated country_of_incorporation", alt_past_perf_poc_last_name: "some updated alt_past_perf_poc_last_name", mailing_address_city: "some updated mailing_address_city", last_update_date: ~D[2025-04-02], past_perf_poc_zip_postal_code: "some updated past_perf_poc_zip_postal_code", entity_url: "some updated entity_url", psc_code_counter: "some updated psc_code_counter", govt_bus_poc_middle_initial: "some updated govt_bus_poc_middle_initial", govt_bus_poc_first_name: "some updated govt_bus_poc_first_name", alt_govt_bus_poc_title: "some updated alt_govt_bus_poc_title", alt_govt_bus_poc_middle_initial: "some updated alt_govt_bus_poc_middle_initial", alt_govt_bus_poc_zip_postal_code: "some updated alt_govt_bus_poc_zip_postal_code", govt_bus_poc_us_phone: "some updated govt_bus_poc_us_phone", purpose_of_registration: "some updated purpose_of_registration", cage_code: "some updated cage_code", alt_govt_bus_poc_us_phone: "some updated alt_govt_bus_poc_us_phone", physical_address_line_1: "some updated physical_address_line_1", company_security_level: "some updated company_security_level", govt_bus_poc_st_add_1: "some updated govt_bus_poc_st_add_1", highest_employee_security_level: "some updated highest_employee_security_level", physical_address_line_2: "some updated physical_address_line_2", state_of_incorporation: "some updated state_of_incorporation", govt_bus_poc_city: "some updated govt_bus_poc_city", past_perf_poc_poc_last_name: "some updated past_perf_poc_poc_last_name", blank_deprecated: "some updated blank_deprecated", alt_govt_bus_poc_st_add_1: "some updated alt_govt_bus_poc_st_add_1", alt_govt_bus_poc_us_phone_ext: "some updated alt_govt_bus_poc_us_phone_ext", naics_code_string: "some updated naics_code_string", past_perf_poc_state_or_province: "some updated past_perf_poc_state_or_province", govt_bus_poc_us_phone_ext: "some updated govt_bus_poc_us_phone_ext"}

      assert {:ok, %Entity{} = entity} = Entities.update_entity(entity, update_attrs)
      assert entity.govt_bus_poc_us_phone_ext == "some updated govt_bus_poc_us_phone_ext"
      assert entity.past_perf_poc_state_or_province == "some updated past_perf_poc_state_or_province"
      assert entity.naics_code_string == "some updated naics_code_string"
      assert entity.alt_govt_bus_poc_us_phone_ext == "some updated alt_govt_bus_poc_us_phone_ext"
      assert entity.alt_govt_bus_poc_st_add_1 == "some updated alt_govt_bus_poc_st_add_1"
      assert entity.blank_deprecated == "some updated blank_deprecated"
      assert entity.past_perf_poc_poc_last_name == "some updated past_perf_poc_poc_last_name"
      assert entity.govt_bus_poc_city == "some updated govt_bus_poc_city"
      assert entity.state_of_incorporation == "some updated state_of_incorporation"
      assert entity.physical_address_line_2 == "some updated physical_address_line_2"
      assert entity.highest_employee_security_level == "some updated highest_employee_security_level"
      assert entity.govt_bus_poc_st_add_1 == "some updated govt_bus_poc_st_add_1"
      assert entity.company_security_level == "some updated company_security_level"
      assert entity.physical_address_line_1 == "some updated physical_address_line_1"
      assert entity.alt_govt_bus_poc_us_phone == "some updated alt_govt_bus_poc_us_phone"
      assert entity.cage_code == "some updated cage_code"
      assert entity.purpose_of_registration == "some updated purpose_of_registration"
      assert entity.govt_bus_poc_us_phone == "some updated govt_bus_poc_us_phone"
      assert entity.alt_govt_bus_poc_zip_postal_code == "some updated alt_govt_bus_poc_zip_postal_code"
      assert entity.alt_govt_bus_poc_middle_initial == "some updated alt_govt_bus_poc_middle_initial"
      assert entity.alt_govt_bus_poc_title == "some updated alt_govt_bus_poc_title"
      assert entity.govt_bus_poc_first_name == "some updated govt_bus_poc_first_name"
      assert entity.govt_bus_poc_middle_initial == "some updated govt_bus_poc_middle_initial"
      assert entity.psc_code_counter == "some updated psc_code_counter"
      assert entity.entity_url == "some updated entity_url"
      assert entity.past_perf_poc_zip_postal_code == "some updated past_perf_poc_zip_postal_code"
      assert entity.last_update_date == ~D[2025-04-02]
      assert entity.mailing_address_city == "some updated mailing_address_city"
      assert entity.alt_past_perf_poc_last_name == "some updated alt_past_perf_poc_last_name"
      assert entity.country_of_incorporation == "some updated country_of_incorporation"
      assert entity.d_b_open_data_flag == "some updated d_b_open_data_flag"
      assert entity.govt_bus_poc_non_us_phone == "some updated govt_bus_poc_non_us_phone"
      assert entity.alt_govt_bus_poc_non_us_phone == "some updated alt_govt_bus_poc_non_us_phone"
      assert entity.business_type_counter == "some updated business_type_counter"
      assert entity.govt_bus_poc_title == "some updated govt_bus_poc_title"
      assert entity.mailing_address_line_1 == "some updated mailing_address_line_1"
      assert entity.past_perf_poc_non_us_phone == "some updated past_perf_poc_non_us_phone"
      assert entity.alt_govt_bus_poc_city == "some updated alt_govt_bus_poc_city"
      assert entity.alt_govt_bus_poc_state_or_province == "some updated alt_govt_bus_poc_state_or_province"
      assert entity.alt_govt_bus_poc_email == "some updated alt_govt_bus_poc_email"
      assert entity.govt_bus_poc_email == "some updated govt_bus_poc_email"
      assert entity.past_perf_poc_fax_us_only == "some updated past_perf_poc_fax_us_only"
      assert entity.past_perf_poc_zip_code_4 == "some updated past_perf_poc_zip_code_4"
      assert entity.alt_govt_bus_poc_st_add_2 == "some updated alt_govt_bus_poc_st_add_2"
      assert entity.alt_past_perf_poc_city == "some updated alt_past_perf_poc_city"
      assert entity.physical_address_country_code == "some updated physical_address_country_code"
      assert entity.entity_division_number == "some updated entity_division_number"
      assert entity.naics_code_counter == "some updated naics_code_counter"
      assert entity.govt_bus_poc_last_name == "some updated govt_bus_poc_last_name"
      assert entity.govt_bus_poc_fax_us_only == "some updated govt_bus_poc_fax_us_only"
      assert entity.physical_address_zip_postal_code == "some updated physical_address_zip_postal_code"
      assert entity.unique_entity_id == "some updated unique_entity_id"
      assert entity.alt_govt_bus_poc_first_name == "some updated alt_govt_bus_poc_first_name"
      assert entity.registration_expiration_date == ~D[2025-04-02]
      assert entity.entity_division_name == "some updated entity_division_name"
      assert entity.agency_business_purpose == "some updated agency_business_purpose"
      assert entity.activation_date == ~D[2025-04-02]
      assert entity.past_perf_poc_poc_title == "some updated past_perf_poc_poc_title"
      assert entity.alt_govt_bus_poc_fax_us_only == "some updated alt_govt_bus_poc_fax_us_only"
      assert entity.entity_structure == "some updated entity_structure"
      assert entity.entity_start_date == ~D[2025-04-02]
      assert entity.mailing_address_zip_code_4 == "some updated mailing_address_zip_code_4"
      assert entity.alt_govt_bus_poc_last_name == "some updated alt_govt_bus_poc_last_name"
      assert entity.mailing_address_country == "some updated mailing_address_country"
      assert entity.govt_bus_poc_zip_code_4 == "some updated govt_bus_poc_zip_code_4"
      assert entity.alt_past_perf_poc_title == "some updated alt_past_perf_poc_title"
      assert entity.past_perf_poc_country_code == "some updated past_perf_poc_country_code"
      assert entity.alt_govt_bus_poc_zip_code_4 == "some updated alt_govt_bus_poc_zip_code_4"
      assert entity.past_perf_poc_st_add_1 == "some updated past_perf_poc_st_add_1"
      assert entity.govt_bus_poc_st_add_2 == "some updated govt_bus_poc_st_add_2"
      assert entity.govt_bus_poc_zip_postal_code == "some updated govt_bus_poc_zip_postal_code"
      assert entity.past_perf_poc_poc_middle_initial == "some updated past_perf_poc_poc_middle_initial"
      assert entity.past_perf_poc_st_add_2 == "some updated past_perf_poc_st_add_2"
      assert entity.correspondence_flag == "some updated correspondence_flag"
      assert entity.fiscal_year_end_close_date == ~D[2025-04-02]
      assert entity.physical_address_city == "some updated physical_address_city"
      assert entity.past_perf_poc_us_phone == "some updated past_perf_poc_us_phone"
      assert entity.past_perf_poc_us_phone_ext == "some updated past_perf_poc_us_phone_ext"
      assert entity.govt_bus_poc_country_code == "some updated govt_bus_poc_country_code"
      assert entity.past_perf_poc_poc_first_name == "some updated past_perf_poc_poc_first_name"
      assert entity.alt_past_perf_poc_st_add_1 == "some updated alt_past_perf_poc_st_add_1"
      assert entity.bus_type_string == "some updated bus_type_string"
      assert entity.physical_address_province_or_state == "some updated physical_address_province_or_state"
      assert entity.mailing_address_zip_postal_code == "some updated mailing_address_zip_postal_code"
      assert entity.dba_name == "some updated dba_name"
      assert entity.past_perf_poc_email == "some updated past_perf_poc_email"
      assert entity.primary_naics == "some updated primary_naics"
      assert entity.dodaac == "some updated dodaac"
      assert entity.alt_past_perf_poc_middle_initial == "some updated alt_past_perf_poc_middle_initial"
      assert entity.psc_code_string == "some updated psc_code_string"
      assert entity.alt_past_perf_poc_st_add_2 == "some updated alt_past_perf_poc_st_add_2"
      assert entity.entity_eft_indicator == "some updated entity_eft_indicator"
      assert entity.alt_govt_bus_poc_country_code == "some updated alt_govt_bus_poc_country_code"
      assert entity.credit_card_usage == "some updated credit_card_usage"
      assert entity.legal_business_name == "some updated legal_business_name"
      assert entity.mailing_address_line_2 == "some updated mailing_address_line_2"
      assert entity.mailing_address_state_or_province == "some updated mailing_address_state_or_province"
      assert entity.past_perf_poc_city == "some updated past_perf_poc_city"
      assert entity.physical_address_congressional_district == "some updated physical_address_congressional_district"
      assert entity.physical_address_zip_code_4 == "some updated physical_address_zip_code_4"
      assert entity.initial_registration_date == ~D[2025-04-02]
      assert entity.govt_bus_poc_state_or_province == "some updated govt_bus_poc_state_or_province"
      assert entity.sam_extract_code == "some updated sam_extract_code"
      assert entity.alt_past_perf_poc_first_name == "some updated alt_past_perf_poc_first_name"
    end

    test "update_entity/2 with invalid data returns error changeset" do
      entity = entity_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_entity(entity, @invalid_attrs)
      assert entity == Entities.get_entity!(entity.id)
    end

    test "delete_entity/1 deletes the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{}} = Entities.delete_entity(entity)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_entity!(entity.id) end
    end

    test "change_entity/1 returns a entity changeset" do
      entity = entity_fixture()
      assert %Ecto.Changeset{} = Entities.change_entity(entity)
    end
  end
end
