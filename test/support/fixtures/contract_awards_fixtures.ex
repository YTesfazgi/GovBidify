defmodule GovBidify.ContractAwardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GovBidify.ContractAwards` context.
  """

  @doc """
  Generate a contract_award.
  """
  def contract_award_fixture(attrs \\ %{}) do
    {:ok, contract_award} =
      attrs
      |> Enum.into(%{
        a76_fair_act_action: "some a76_fair_act_action",
        a76_fair_act_action_code: "some a76_fair_act_action_code",
        action_date: ~D[2023-01-01],
        action_date_fiscal_year: 2023,
        action_type: "some action_type",
        action_type_code: "some action_type_code",
        airport_authority: "some airport_authority",
        alaskan_native_corporation_owned_firm: "some alaskan_native_corporation_owned_firm",
        alaskan_native_servicing_institution: "some alaskan_native_servicing_institution",
        american_indian_owned_business: "some american_indian_owned_business",
        asian_pacific_american_owned_business: "some asian_pacific_american_owned_business",
        award_id_piid: "some award_id_piid",
        award_or_idv_flag: "some award_or_idv_flag",
        award_type: "some award_type",
        award_type_code: "some award_type_code",
        awarding_agency_code: "some awarding_agency_code",
        awarding_agency_name: "some awarding_agency_name",
        awarding_office_code: "some awarding_office_code",
        awarding_office_name: "some awarding_office_name",
        awarding_sub_agency_code: "some awarding_sub_agency_code",
        awarding_sub_agency_name: "some awarding_sub_agency_name",
        base_and_all_options_value: "some base_and_all_options_value",
        base_and_exercised_options_value: "some base_and_exercised_options_value",
        black_american_owned_business: "some black_american_owned_business",
        c8a_program_participant: "some c8a_program_participant",
        cage_code: "some cage_code",
        city_local_government: "some city_local_government",
        clinger_cohen_act_planning: "some clinger_cohen_act_planning",
        clinger_cohen_act_planning_code: "some clinger_cohen_act_planning_code",
        commercial_item_acquisition_procedures: "some commercial_item_acquisition_procedures",
        commercial_item_acquisition_procedures_code: "some commercial_item_acquisition_procedures_code",
        community_developed_corporation_owned_firm: "some community_developed_corporation_owned_firm",
        community_development_corporation: "some community_development_corporation",
        consolidated_contract: "some consolidated_contract",
        consolidated_contract_code: "some consolidated_contract_code",
        construction_wage_rate_requirements: "some construction_wage_rate_requirements",
        construction_wage_rate_requirements_code: "some construction_wage_rate_requirements_code",
        contingency_humanitarian_or_peacekeeping_operation: "some contingency_humanitarian_or_peacekeeping_operation",
        contingency_humanitarian_or_peacekeeping_operation_code: "some contingency_humanitarian_or_peacekeeping_operation_code",
        contract_award_unique_key: "some contract_award_unique_key",
        contract_bundling: "some contract_bundling",
        contract_bundling_code: "some contract_bundling_code",
        contract_financing: "some contract_financing",
        contract_financing_code: "some contract_financing_code",
        contract_transaction_unique_key: "some contract_transaction_unique_key",
        contracting_officers_determination_of_business_size: "some contracting_officers_determination_of_business_size",
        contracting_officers_determination_of_business_size_code: "some contracting_officers_determination_of_business_size_code",
        corporate_entity_not_tax_exempt: "some corporate_entity_not_tax_exempt",
        corporate_entity_tax_exempt: "some corporate_entity_tax_exempt",
        cost_accounting_standards_clause: "some cost_accounting_standards_clause",
        cost_accounting_standards_clause_code: "some cost_accounting_standards_clause_code",
        cost_or_pricing_data: "some cost_or_pricing_data",
        cost_or_pricing_data_code: "some cost_or_pricing_data_code",
        council_of_governments: "some council_of_governments",
        country_of_product_or_service_origin: "some country_of_product_or_service_origin",
        country_of_product_or_service_origin_code: "some country_of_product_or_service_origin_code",
        county_local_government: "some county_local_government",
        current_total_value_of_award: "some current_total_value_of_award",
        disaster_emergency_fund_codes_for_overall_award: "some disaster_emergency_fund_codes_for_overall_award",
        dod_acquisition_program_code: "some dod_acquisition_program_code",
        dod_acquisition_program_description: "some dod_acquisition_program_description",
        dod_claimant_program_code: "some dod_claimant_program_code",
        dod_claimant_program_description: "some dod_claimant_program_description",
        domestic_or_foreign_entity: "some domestic_or_foreign_entity",
        domestic_or_foreign_entity_code: "some domestic_or_foreign_entity_code",
        domestic_shelter: "some domestic_shelter",
        dot_certified_disadvantage: "some dot_certified_disadvantage",
        economically_disadvantaged_women_owned_small_business: "some economically_disadvantaged_women_owned_small_business",
        educational_institution: "some educational_institution",
        emerging_small_business: "some emerging_small_business",
        epa_designated_product: "some epa_designated_product",
        epa_designated_product_code: "some epa_designated_product_code",
        evaluated_preference: "some evaluated_preference",
        evaluated_preference_code: "some evaluated_preference_code",
        extent_competed: "some extent_competed",
        extent_competed_code: "some extent_competed_code",
        fair_opportunity_limited_sources: "some fair_opportunity_limited_sources",
        fair_opportunity_limited_sources_code: "some fair_opportunity_limited_sources_code",
        fed_biz_opps: "some fed_biz_opps",
        fed_biz_opps_code: "some fed_biz_opps_code",
        federal_accounts_funding_this_award: "some federal_accounts_funding_this_award",
        federal_action_obligation: "some federal_action_obligation",
        federal_agency: "some federal_agency",
        federally_funded_research_and_development_corp: "some federally_funded_research_and_development_corp",
        for_profit_organization: "some for_profit_organization",
        foreign_funding: "some foreign_funding",
        foreign_funding_description: "some foreign_funding_description",
        foreign_government: "some foreign_government",
        foreign_owned: "some foreign_owned",
        foundation: "some foundation",
        funding_agency_code: "some funding_agency_code",
        funding_agency_name: "some funding_agency_name",
        funding_office_code: "some funding_office_code",
        funding_office_name: "some funding_office_name",
        funding_sub_agency_code: "some funding_sub_agency_code",
        funding_sub_agency_name: "some funding_sub_agency_name",
        government_furnished_property: "some government_furnished_property",
        government_furnished_property_code: "some government_furnished_property_code",
        highly_compensated_officer_1_amount: "some highly_compensated_officer_1_amount",
        highly_compensated_officer_1_name: "some highly_compensated_officer_1_name",
        highly_compensated_officer_2_amount: "some highly_compensated_officer_2_amount",
        highly_compensated_officer_2_name: "some highly_compensated_officer_2_name",
        highly_compensated_officer_3_amount: "some highly_compensated_officer_3_amount",
        highly_compensated_officer_3_name: "some highly_compensated_officer_3_name",
        highly_compensated_officer_4_amount: "some highly_compensated_officer_4_amount",
        highly_compensated_officer_4_name: "some highly_compensated_officer_4_name",
        highly_compensated_officer_5_amount: "some highly_compensated_officer_5_amount",
        highly_compensated_officer_5_name: "some highly_compensated_officer_5_name",
        hispanic_american_owned_business: "some hispanic_american_owned_business",
        hispanic_servicing_institution: "some hispanic_servicing_institution",
        historically_black_college: "some historically_black_college",
        historically_underutilized_business_zone_hubzone_firm: "some historically_underutilized_business_zone_hubzone_firm",
        hospital_flag: "some hospital_flag",
        housing_authorities_public_tribal: "some housing_authorities_public_tribal",
        idv_type: "some idv_type",
        idv_type_code: "some idv_type_code",
        indian_tribe_federally_recognized: "some indian_tribe_federally_recognized",
        information_technology_commercial_item_category: "some information_technology_commercial_item_category",
        information_technology_commercial_item_category_code: "some information_technology_commercial_item_category_code",
        inherently_governmental_functions: "some inherently_governmental_functions",
        inherently_governmental_functions_description: "some inherently_governmental_functions_description",
        initial_report_date: ~D[2022-12-15],
        inter_municipal_local_government: "some inter_municipal_local_government",
        interagency_contracting_authority: "some interagency_contracting_authority",
        interagency_contracting_authority_code: "some interagency_contracting_authority_code",
        international_organization: "some international_organization",
        interstate_entity: "some interstate_entity",
        joint_venture_economic_disadvantaged_women_owned_small_bus: "some joint_venture_economic_disadvantaged_women_owned_small_bus",
        joint_venture_women_owned_small_business: "some joint_venture_women_owned_small_business",
        labor_standards: "some labor_standards",
        labor_standards_code: "some labor_standards_code",
        labor_surplus_area_firm: "some labor_surplus_area_firm",
        land_grant_college: "some land_grant_college",
        last_modified_date: ~D[2023-01-15],
        limited_liability_corporation: "some limited_liability_corporation",
        local_area_set_aside: "some local_area_set_aside",
        local_area_set_aside_code: "some local_area_set_aside_code",
        local_government_owned: "some local_government_owned",
        major_program: "some major_program",
        manufacturer_of_goods: "some manufacturer_of_goods",
        materials_supplies_articles_equipment: "some materials_supplies_articles_equipment",
        materials_supplies_articles_equipment_code: "some materials_supplies_articles_equipment_code",
        minority_institution: "some minority_institution",
        minority_owned_business: "some minority_owned_business",
        modification_number: "some modification_number",
        multi_year_contract: "some multi_year_contract",
        multi_year_contract_code: "some multi_year_contract_code",
        multiple_or_single_award_idv: "some multiple_or_single_award_idv",
        multiple_or_single_award_idv_code: "some multiple_or_single_award_idv_code",
        municipality_local_government: "some municipality_local_government",
        naics_code: "some naics_code",
        naics_description: "some naics_description",
        national_interest_action: "some national_interest_action",
        national_interest_action_code: "some national_interest_action_code",
        native_american_owned_business: "some native_american_owned_business",
        native_hawaiian_organization_owned_firm: "some native_hawaiian_organization_owned_firm",
        native_hawaiian_servicing_institution: "some native_hawaiian_servicing_institution",
        nonprofit_organization: "some nonprofit_organization",
        number_of_actions: "some number_of_actions",
        number_of_offers_received: "some number_of_offers_received",
        object_classes_funding_this_award: "some object_classes_funding_this_award",
        "obligated_amount_from_COVID-19_supplementals_for_overall_award": "some obligated_amount_from_COVID-19_supplementals_for_overall_award",
        obligated_amount_from_IIJA_supplemental_for_overall_award: "some obligated_amount_from_IIJA_supplemental_for_overall_award",
        ordering_period_end_date: ~D[2023-12-31],
        organizational_type: "some organizational_type",
        other_minority_owned_business: "some other_minority_owned_business",
        other_not_for_profit_organization: "some other_not_for_profit_organization",
        other_statutory_authority: "some other_statutory_authority",
        other_than_full_and_open_competition: "some other_than_full_and_open_competition",
        other_than_full_and_open_competition_code: "some other_than_full_and_open_competition_code",
        "outlayed_amount_from_COVID-19_supplementals_for_overall_award": "some outlayed_amount_from_COVID-19_supplementals_for_overall_award",
        outlayed_amount_from_IIJA_supplemental_for_overall_award: "some outlayed_amount_from_IIJA_supplemental_for_overall_award",
        parent_award_agency_id: "some parent_award_agency_id",
        parent_award_agency_name: "some parent_award_agency_name",
        parent_award_id_piid: "some parent_award_id_piid",
        parent_award_modification_number: "some parent_award_modification_number",
        parent_award_single_or_multiple: "some parent_award_single_or_multiple",
        parent_award_single_or_multiple_code: "some parent_award_single_or_multiple_code",
        parent_award_type: "some parent_award_type",
        parent_award_type_code: "some parent_award_type_code",
        partnership_or_limited_liability_partnership: "some partnership_or_limited_liability_partnership",
        performance_based_service_acquisition: "some performance_based_service_acquisition",
        performance_based_service_acquisition_code: "some performance_based_service_acquisition_code",
        period_of_performance_current_end_date: ~D[2023-12-31],
        period_of_performance_potential_end_date: ~N[2023-12-31 23:59:59],
        period_of_performance_start_date: ~D[2023-01-01],
        place_of_manufacture: "some place_of_manufacture",
        place_of_manufacture_code: "some place_of_manufacture_code",
        planning_commission: "some planning_commission",
        port_authority: "some port_authority",
        potential_total_value_of_award: "some potential_total_value_of_award",
        price_evaluation_adjustment_preference_percent_difference: "some price_evaluation_adjustment_preference_percent_difference",
        primary_place_of_performance_city_name: "some primary_place_of_performance_city_name",
        primary_place_of_performance_country_code: "some primary_place_of_performance_country_code",
        primary_place_of_performance_country_name: "some primary_place_of_performance_country_name",
        primary_place_of_performance_county_name: "some primary_place_of_performance_county_name",
        primary_place_of_performance_state_code: "some primary_place_of_performance_state_code",
        primary_place_of_performance_state_name: "some primary_place_of_performance_state_name",
        primary_place_of_performance_zip_4: "some primary_place_of_performance_zip_4",
        prime_award_base_transaction_description: "some prime_award_base_transaction_description",
        prime_award_transaction_place_of_performance_cd_current: "some prime_award_transaction_place_of_performance_cd_current",
        prime_award_transaction_place_of_performance_cd_original: "some prime_award_transaction_place_of_performance_cd_original",
        prime_award_transaction_place_of_performance_county_fips_code: "some prime_award_transaction_place_of_performance_county_fips_code",
        prime_award_transaction_place_of_performance_state_fips_code: "some prime_award_transaction_place_of_performance_state_fips_code",
        prime_award_transaction_recipient_cd_current: "some prime_award_transaction_recipient_cd_current",
        prime_award_transaction_recipient_cd_original: "some prime_award_transaction_recipient_cd_original",
        prime_award_transaction_recipient_county_fips_code: "some prime_award_transaction_recipient_county_fips_code",
        prime_award_transaction_recipient_state_fips_code: "some prime_award_transaction_recipient_state_fips_code",
        private_university_or_college: "some private_university_or_college",
        product_or_service_code: "some product_or_service_code",
        product_or_service_code_description: "some product_or_service_code_description",
        program_acronym: "some program_acronym",
        program_activities_funding_this_award: "some program_activities_funding_this_award",
        purchase_card_as_payment_method: "some purchase_card_as_payment_method",
        purchase_card_as_payment_method_code: "some purchase_card_as_payment_method_code",
        receives_contracts: "some receives_contracts",
        receives_contracts_and_financial_assistance: "some receives_contracts_and_financial_assistance",
        receives_financial_assistance: "some receives_financial_assistance",
        recipient_address_line_1: "some recipient_address_line_1",
        recipient_address_line_2: "some recipient_address_line_2",
        recipient_city_name: "some recipient_city_name",
        recipient_country_code: "some recipient_country_code",
        recipient_country_name: "some recipient_country_name",
        recipient_county_name: "some recipient_county_name",
        recipient_doing_business_as_name: "some recipient_doing_business_as_name",
        recipient_duns: "some recipient_duns",
        recipient_fax_number: "some recipient_fax_number",
        recipient_name: "some recipient_name",
        recipient_name_raw: "some recipient_name_raw",
        recipient_parent_duns: "some recipient_parent_duns",
        recipient_parent_name: "some recipient_parent_name",
        recipient_parent_name_raw: "some recipient_parent_name_raw",
        recipient_parent_uei: "some recipient_parent_uei",
        recipient_phone_number: "some recipient_phone_number",
        recipient_state_code: "some recipient_state_code",
        recipient_state_name: "some recipient_state_name",
        recipient_uei: "some recipient_uei",
        recipient_zip_4_code: "some recipient_zip_4_code",
        recovered_materials_sustainability: "some recovered_materials_sustainability",
        recovered_materials_sustainability_code: "some recovered_materials_sustainability_code",
        research: "some research",
        research_code: "some research_code",
        sam_exception: "some sam_exception",
        sam_exception_description: "some sam_exception_description",
        sba_certified_8a_joint_venture: "some sba_certified_8a_joint_venture",
        school_district_local_government: "some school_district_local_government",
        school_of_forestry: "some school_of_forestry",
        sea_transportation: "some sea_transportation",
        sea_transportation_code: "some sea_transportation_code",
        self_certified_small_disadvantaged_business: "some self_certified_small_disadvantaged_business",
        service_disabled_veteran_owned_business: "some service_disabled_veteran_owned_business",
        simplified_procedures_for_certain_commercial_items: "some simplified_procedures_for_certain_commercial_items",
        simplified_procedures_for_certain_commercial_items_code: "some simplified_procedures_for_certain_commercial_items_code",
        small_agricultural_cooperative: "some small_agricultural_cooperative",
        small_business_competitiveness_demonstration_program: "some small_business_competitiveness_demonstration_program",
        small_disadvantaged_business: "some small_disadvantaged_business",
        sole_proprietorship: "some sole_proprietorship",
        solicitation_date: ~D[2022-12-01],
        solicitation_identifier: "some solicitation_identifier",
        solicitation_procedures: "some solicitation_procedures",
        solicitation_procedures_code: "some solicitation_procedures_code",
        state_controlled_institution_of_higher_learning: "some state_controlled_institution_of_higher_learning",
        subchapter_scorporation: "some subchapter_scorporation",
        subcontinent_asian_asian_indian_american_owned_business: "some subcontinent_asian_asian_indian_american_owned_business",
        subcontracting_plan: "some subcontracting_plan",
        subcontracting_plan_code: "some subcontracting_plan_code",
        the_ability_one_program: "some the_ability_one_program",
        total_dollars_obligated: "some total_dollars_obligated",
        total_outlayed_amount_for_overall_award: "some total_outlayed_amount_for_overall_award",
        township_local_government: "some township_local_government",
        transaction_description: "some transaction_description",
        transaction_number: "some transaction_number",
        transit_authority: "some transit_authority",
        treasury_accounts_funding_this_award: "some treasury_accounts_funding_this_award",
        tribal_college: "some tribal_college",
        tribally_owned_firm: "some tribally_owned_firm",
        type_of_contract_pricing: "some type_of_contract_pricing",
        type_of_contract_pricing_code: "some type_of_contract_pricing_code",
        type_of_idc: "some type_of_idc",
        type_of_idc_code: "some type_of_idc_code",
        type_of_set_aside: "some type_of_set_aside",
        type_of_set_aside_code: "some type_of_set_aside_code",
        undefinitized_action: "some undefinitized_action",
        undefinitized_action_code: "some undefinitized_action_code",
        us_federal_government: "some us_federal_government",
        us_government_entity: "some us_government_entity",
        us_local_government: "some us_local_government",
        us_state_government: "some us_state_government",
        us_tribal_government: "some us_tribal_government",
        usaspending_permalink: "some usaspending_permalink",
        veteran_owned_business: "some veteran_owned_business",
        veterinary_college: "some veterinary_college",
        veterinary_hospital: "some veterinary_hospital",
        woman_owned_business: "some woman_owned_business",
        women_owned_small_business: "some women_owned_small_business",
        "1862_land_grant_college": true,
        "1890_land_grant_college": true,
        "1994_land_grant_college": true
      })
      |> GovBidify.ContractAwards.create_contract_award()

    contract_award
  end
end
