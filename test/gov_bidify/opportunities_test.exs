defmodule GovBidify.OpportunitiesTest do
  use GovBidify.DataCase

  import GovBidify.Factory
  alias GovBidify.Opportunities

  describe "opportunities" do
    alias GovBidify.Opportunities.Opportunity

    import GovBidify.OpportunitiesFixtures

    @invalid_attrs %{country_code: nil, state: nil, set_aside: nil, secondary_contact_title: nil, archive_type: nil, classification_code: nil, city: nil, sol: nil, base_type: nil, award_date: nil, posted_date: nil, title: nil, secondary_contact_fullname: nil, primary_contact_email: nil, type: nil, description: nil, fpds_code: nil, secondary_contact_email: nil, additional_info_link: nil, link: nil, award_number: nil, secondary_contact_fax: nil, primary_contact_title: nil, aac_code: nil, response_deadline: nil, organization_type: nil, zip_code: nil, set_aside_code: nil, active: nil, archive_date: nil, award: nil, primary_contact_fullname: nil, pop_city: nil, notice_id: nil, sub_tier: nil, naics_code: nil, pop_country: nil, primary_contact_fax: nil, pop_street_address: nil, office: nil, cgac: nil, pop_state: nil, pop_zip: nil, department_ind_agency: nil, primary_contact_phone: nil, secondary_contact_phone: nil, awardee: nil}

    test "list_opportunities/0 returns all opportunities" do
      opportunity = opportunity_fixture()
      assert Opportunities.list_opportunities() == [opportunity]
    end

    test "get_opportunity!/1 returns the opportunity with given id" do
      opportunity = opportunity_fixture()
      assert Opportunities.get_opportunity!(opportunity.id) == opportunity
    end

    test "create_opportunity/1 with valid data creates an opportunity" do
      valid_attrs = %{country_code: "some country_code", state: "some state", set_aside: "some set_aside", secondary_contact_title: "some secondary_contact_title", archive_type: "some archive_type", classification_code: "some classification_code", city: "some city", sol: "some sol", base_type: "some base_type", award_date: ~D[2024-06-12], posted_date: ~D[2024-06-12], title: "some title", secondary_contact_fullname: "some secondary_contact_fullname", primary_contact_email: "some primary_contact_email", type: "some type", description: "some description", fpds_code: "some fpds_code", secondary_contact_email: "some secondary_contact_email", additional_info_link: "some additional_info_link", link: "some link", award_number: "some award_number", secondary_contact_fax: "some secondary_contact_fax", primary_contact_title: "some primary_contact_title", aac_code: "some aac_code", response_deadline: "2024-06-26T10:00:00-07:00", organization_type: "some organization_type", zip_code: "some zip_code", set_aside_code: "some set_aside_code", active: "some active", archive_date: ~D[2024-06-12], award: "some award", primary_contact_fullname: "some primary_contact_fullname", pop_city: "some pop_city", notice_id: "some notice_id", sub_tier: "some sub_tier", naics_code: "some naics_code", pop_country: "some pop_country", primary_contact_fax: "some primary_contact_fax", pop_street_address: "some pop_street_address", office: "some office", cgac: "some cgac", pop_state: "some pop_state", pop_zip: "some pop_zip", department_ind_agency: "some department_ind_agency", primary_contact_phone: "some primary_contact_phone", secondary_contact_phone: "some secondary_contact_phone", awardee: "some awardee"}

      assert {:ok, %Opportunity{} = opportunity} = Opportunities.create_opportunity(valid_attrs)
      assert opportunity.awardee == "some awardee"
      assert opportunity.secondary_contact_phone == "some secondary_contact_phone"
      assert opportunity.primary_contact_phone == "some primary_contact_phone"
      assert opportunity.department_ind_agency == "some department_ind_agency"
      assert opportunity.pop_zip == "some pop_zip"
      assert opportunity.pop_state == "some pop_state"
      assert opportunity.cgac == "some cgac"
      assert opportunity.office == "some office"
      assert opportunity.pop_street_address == "some pop_street_address"
      assert opportunity.primary_contact_fax == "some primary_contact_fax"
      assert opportunity.pop_country == "some pop_country"
      assert opportunity.naics_code == "some naics_code"
      assert opportunity.sub_tier == "some sub_tier"
      assert opportunity.notice_id == "some notice_id"
      assert opportunity.pop_city == "some pop_city"
      assert opportunity.primary_contact_fullname == "some primary_contact_fullname"
      assert opportunity.award == "some award"
      assert opportunity.archive_date == ~D[2024-06-12]
      assert opportunity.active == "some active"
      assert opportunity.set_aside_code == "some set_aside_code"
      assert opportunity.zip_code == "some zip_code"
      assert opportunity.organization_type == "some organization_type"
      assert opportunity.response_deadline == ~U[2024-06-26 17:00:00Z]
      assert opportunity.aac_code == "some aac_code"
      assert opportunity.primary_contact_title == "some primary_contact_title"
      assert opportunity.secondary_contact_fax == "some secondary_contact_fax"
      assert opportunity.award_number == "some award_number"
      assert opportunity.link == "some link"
      assert opportunity.additional_info_link == "some additional_info_link"
      assert opportunity.secondary_contact_email == "some secondary_contact_email"
      assert opportunity.fpds_code == "some fpds_code"
      assert opportunity.description == "some description"
      assert opportunity.type == "some type"
      assert opportunity.primary_contact_email == "some primary_contact_email"
      assert opportunity.secondary_contact_fullname == "some secondary_contact_fullname"
      assert opportunity.title == "some title"
      assert opportunity.posted_date == ~D[2024-06-12]
      assert opportunity.award_date == ~D[2024-06-12]
      assert opportunity.base_type == "some base_type"
      assert opportunity.sol == "some sol"
      assert opportunity.city == "some city"
      assert opportunity.classification_code == "some classification_code"
      assert opportunity.archive_type == "some archive_type"
      assert opportunity.secondary_contact_title == "some secondary_contact_title"
      assert opportunity.set_aside == "some set_aside"
      assert opportunity.state == "some state"
      assert opportunity.country_code == "some country_code"
    end

    test "create_opportunity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Opportunities.create_opportunity(@invalid_attrs)
    end

    test "update_opportunity/2 with valid data updates the opportunity" do
      opportunity = opportunity_fixture()
      update_attrs = %{country_code: "some updated country_code", state: "some updated state", set_aside: "some updated set_aside", secondary_contact_title: "some updated secondary_contact_title", archive_type: "some updated archive_type", classification_code: "some updated classification_code", city: "some updated city", sol: "some updated sol", base_type: "some updated base_type", award_date: ~D[2024-06-12], posted_date: ~D[2024-06-12], title: "some updated title", secondary_contact_fullname: "some updated secondary_contact_fullname", primary_contact_email: "some updated primary_contact_email", type: "some updated type", description: "some updated description", fpds_code: "some updated fpds_code", secondary_contact_email: "some updated secondary_contact_email", additional_info_link: "some updated additional_info_link", link: "some updated link", award_number: "some updated award_number", secondary_contact_fax: "some updated secondary_contact_fax", primary_contact_title: "some updated primary_contact_title", aac_code: "some updated aac_code", response_deadline: "2024-06-25T10:00:00-07:00", organization_type: "some updated organization_type", zip_code: "some updated zip_code", set_aside_code: "some updated set_aside_code", active: "some updated active", archive_date: ~D[2024-06-12], award: "some updated award", primary_contact_fullname: "some updated primary_contact_fullname", pop_city: "some updated pop_city", notice_id: "some updated notice_id", sub_tier: "some updated sub_tier", naics_code: "some updated naics_code", pop_country: "some updated pop_country", primary_contact_fax: "some updated primary_contact_fax", pop_street_address: "some updated pop_street_address", office: "some updated office", cgac: "some updated cgac", pop_state: "some updated pop_state", pop_zip: "some updated pop_zip", department_ind_agency: "some updated department_ind_agency", primary_contact_phone: "some updated primary_contact_phone", secondary_contact_phone: "some updated secondary_contact_phone", awardee: "some updated awardee"}

      assert {:ok, %Opportunity{} = opportunity} = Opportunities.update_opportunity(opportunity, update_attrs)
      assert opportunity.awardee == "some updated awardee"
      assert opportunity.secondary_contact_phone == "some updated secondary_contact_phone"
      assert opportunity.primary_contact_phone == "some updated primary_contact_phone"
      assert opportunity.department_ind_agency == "some updated department_ind_agency"
      assert opportunity.pop_zip == "some updated pop_zip"
      assert opportunity.pop_state == "some updated pop_state"
      assert opportunity.cgac == "some updated cgac"
      assert opportunity.office == "some updated office"
      assert opportunity.pop_street_address == "some updated pop_street_address"
      assert opportunity.primary_contact_fax == "some updated primary_contact_fax"
      assert opportunity.pop_country == "some updated pop_country"
      assert opportunity.naics_code == "some updated naics_code"
      assert opportunity.sub_tier == "some updated sub_tier"
      assert opportunity.notice_id == "some updated notice_id"
      assert opportunity.pop_city == "some updated pop_city"
      assert opportunity.primary_contact_fullname == "some updated primary_contact_fullname"
      assert opportunity.award == "some updated award"
      assert opportunity.archive_date == ~D[2024-06-12]
      assert opportunity.active == "some updated active"
      assert opportunity.set_aside_code == "some updated set_aside_code"
      assert opportunity.zip_code == "some updated zip_code"
      assert opportunity.organization_type == "some updated organization_type"
      assert opportunity.response_deadline == ~U[2024-06-25 17:00:00Z]
      assert opportunity.aac_code == "some updated aac_code"
      assert opportunity.primary_contact_title == "some updated primary_contact_title"
      assert opportunity.secondary_contact_fax == "some updated secondary_contact_fax"
      assert opportunity.award_number == "some updated award_number"
      assert opportunity.link == "some updated link"
      assert opportunity.additional_info_link == "some updated additional_info_link"
      assert opportunity.secondary_contact_email == "some updated secondary_contact_email"
      assert opportunity.fpds_code == "some updated fpds_code"
      assert opportunity.description == "some updated description"
      assert opportunity.type == "some updated type"
      assert opportunity.primary_contact_email == "some updated primary_contact_email"
      assert opportunity.secondary_contact_fullname == "some updated secondary_contact_fullname"
      assert opportunity.title == "some updated title"
      assert opportunity.posted_date == ~D[2024-06-12]
      assert opportunity.award_date == ~D[2024-06-12]
      assert opportunity.base_type == "some updated base_type"
      assert opportunity.sol == "some updated sol"
      assert opportunity.city == "some updated city"
      assert opportunity.classification_code == "some updated classification_code"
      assert opportunity.archive_type == "some updated archive_type"
      assert opportunity.secondary_contact_title == "some updated secondary_contact_title"
      assert opportunity.set_aside == "some updated set_aside"
      assert opportunity.state == "some updated state"
      assert opportunity.country_code == "some updated country_code"
    end

    test "update_opportunity/2 with invalid data returns error changeset" do
      opportunity = opportunity_fixture()
      assert {:error, %Ecto.Changeset{}} = Opportunities.update_opportunity(opportunity, @invalid_attrs)
      assert opportunity == Opportunities.get_opportunity!(opportunity.id)
    end

    test "delete_opportunity/1 deletes the opportunity" do
      opportunity = opportunity_fixture()
      assert {:ok, %Opportunity{}} = Opportunities.delete_opportunity(opportunity)
      assert_raise Ecto.NoResultsError, fn -> Opportunities.get_opportunity!(opportunity.id) end
    end

    test "change_opportunity/1 returns an opportunity changeset" do
      opportunity = opportunity_fixture()
      assert %Ecto.Changeset{} = Opportunities.change_opportunity(opportunity)
    end

    test "search_opportunities_by_title_and_description/1 returns a list of opportunities" do
      opportunity = opportunity_fixture()
      assert Opportunities.search_opportunities_by_title_and_description("some") == [opportunity]
    end

    test "opportunity_factory works" do
      _opportunity = build(:opportunity)
    end
  end
end
