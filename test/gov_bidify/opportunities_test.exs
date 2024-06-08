defmodule GovBidify.OpportunitiesTest do
  use GovBidify.DataCase

  alias GovBidify.Opportunities

  describe "sam_opportunities" do
    alias GovBidify.Opportunities.SAMOpportunity

    import GovBidify.OpportunitiesFixtures

    @invalid_attrs %{country_code: nil, state: nil, set_aside: nil, secondary_contact_title: nil, archive_type: nil, classification_code: nil, city: nil, sol: nil, base_type: nil, award_date: nil, posted_date: nil, title: nil, secondary_contact_fullname: nil, primary_contact_email: nil, type: nil, description: nil, fpds_code: nil, secondary_contact_email: nil, additional_info_link: nil, link: nil, award_number: nil, secondary_contact_fax: nil, primary_contact_title: nil, aac_code: nil, response_deadline: nil, organization_type: nil, zip_code: nil, set_aside_code: nil, active: nil, archive_date: nil, award: nil, primary_contact_fullname: nil, pop_city: nil, notice_id: nil, sub_tier: nil, naics_code: nil, pop_country: nil, primary_contact_fax: nil, pop_street_address: nil, office: nil, cgac: nil, pop_state: nil, pop_zip: nil, department_ind_agency: nil, primary_contact_phone: nil, secondary_contact_phone: nil, awardee: nil}

    test "list_sam_opportunities/0 returns all sam_opportunities" do
      sam_opportunity = sam_opportunity_fixture()
      assert Opportunities.list_sam_opportunities() == [sam_opportunity]
    end

    test "get_sam_opportunity!/1 returns the sam_opportunity with given id" do
      sam_opportunity = sam_opportunity_fixture()
      assert Opportunities.get_sam_opportunity!(sam_opportunity.id) == sam_opportunity
    end

    test "create_sam_opportunity/1 with valid data creates a sam_opportunity" do
      valid_attrs = %{country_code: "some country_code", state: "some state", set_aside: "some set_aside", secondary_contact_title: "some secondary_contact_title", archive_type: "some archive_type", classification_code: "some classification_code", city: "some city", sol: "some sol", base_type: "some base_type", award_date: "some award_date", posted_date: "some posted_date", title: "some title", secondary_contact_fullname: "some secondary_contact_fullname", primary_contact_email: "some primary_contact_email", type: "some type", description: "some description", fpds_code: "some fpds_code", secondary_contact_email: "some secondary_contact_email", additional_info_link: "some additional_info_link", link: "some link", award_number: "some award_number", secondary_contact_fax: "some secondary_contact_fax", primary_contact_title: "some primary_contact_title", aac_code: "some aac_code", response_deadline: "some response_deadline", organization_type: "some organization_type", zip_code: "some zip_code", set_aside_code: "some set_aside_code", active: "some active", archive_date: "some archive_date", award: "some award", primary_contact_fullname: "some primary_contact_fullname", pop_city: "some pop_city", notice_id: "some notice_id", sub_tier: "some sub_tier", naics_code: "some naics_code", pop_country: "some pop_country", primary_contact_fax: "some primary_contact_fax", pop_street_address: "some pop_street_address", office: "some office", cgac: "some cgac", pop_state: "some pop_state", pop_zip: "some pop_zip", department_ind_agency: "some department_ind_agency", primary_contact_phone: "some primary_contact_phone", secondary_contact_phone: "some secondary_contact_phone", awardee: "some awardee"}

      assert {:ok, %SAMOpportunity{} = sam_opportunity} = Opportunities.create_sam_opportunity(valid_attrs)
      assert sam_opportunity.awardee == "some awardee"
      assert sam_opportunity.secondary_contact_phone == "some secondary_contact_phone"
      assert sam_opportunity.primary_contact_phone == "some primary_contact_phone"
      assert sam_opportunity.department_ind_agency == "some department_ind_agency"
      assert sam_opportunity.pop_zip == "some pop_zip"
      assert sam_opportunity.pop_state == "some pop_state"
      assert sam_opportunity.cgac == "some cgac"
      assert sam_opportunity.office == "some office"
      assert sam_opportunity.pop_street_address == "some pop_street_address"
      assert sam_opportunity.primary_contact_fax == "some primary_contact_fax"
      assert sam_opportunity.pop_country == "some pop_country"
      assert sam_opportunity.naics_code == "some naics_code"
      assert sam_opportunity.sub_tier == "some sub_tier"
      assert sam_opportunity.notice_id == "some notice_id"
      assert sam_opportunity.pop_city == "some pop_city"
      assert sam_opportunity.primary_contact_fullname == "some primary_contact_fullname"
      assert sam_opportunity.award == "some award"
      assert sam_opportunity.archive_date == "some archive_date"
      assert sam_opportunity.active == "some active"
      assert sam_opportunity.set_aside_code == "some set_aside_code"
      assert sam_opportunity.zip_code == "some zip_code"
      assert sam_opportunity.organization_type == "some organization_type"
      assert sam_opportunity.response_deadline == "some response_deadline"
      assert sam_opportunity.aac_code == "some aac_code"
      assert sam_opportunity.primary_contact_title == "some primary_contact_title"
      assert sam_opportunity.secondary_contact_fax == "some secondary_contact_fax"
      assert sam_opportunity.award_number == "some award_number"
      assert sam_opportunity.link == "some link"
      assert sam_opportunity.additional_info_link == "some additional_info_link"
      assert sam_opportunity.secondary_contact_email == "some secondary_contact_email"
      assert sam_opportunity.fpds_code == "some fpds_code"
      assert sam_opportunity.description == "some description"
      assert sam_opportunity.type == "some type"
      assert sam_opportunity.primary_contact_email == "some primary_contact_email"
      assert sam_opportunity.secondary_contact_fullname == "some secondary_contact_fullname"
      assert sam_opportunity.title == "some title"
      assert sam_opportunity.posted_date == "some posted_date"
      assert sam_opportunity.award_date == "some award_date"
      assert sam_opportunity.base_type == "some base_type"
      assert sam_opportunity.sol == "some sol"
      assert sam_opportunity.city == "some city"
      assert sam_opportunity.classification_code == "some classification_code"
      assert sam_opportunity.archive_type == "some archive_type"
      assert sam_opportunity.secondary_contact_title == "some secondary_contact_title"
      assert sam_opportunity.set_aside == "some set_aside"
      assert sam_opportunity.state == "some state"
      assert sam_opportunity.country_code == "some country_code"
    end

    test "create_sam_opportunity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Opportunities.create_sam_opportunity(@invalid_attrs)
    end

    test "update_sam_opportunity/2 with valid data updates the sam_opportunity" do
      sam_opportunity = sam_opportunity_fixture()
      update_attrs = %{country_code: "some updated country_code", state: "some updated state", set_aside: "some updated set_aside", secondary_contact_title: "some updated secondary_contact_title", archive_type: "some updated archive_type", classification_code: "some updated classification_code", city: "some updated city", sol: "some updated sol", base_type: "some updated base_type", award_date: "some updated award_date", posted_date: "some updated posted_date", title: "some updated title", secondary_contact_fullname: "some updated secondary_contact_fullname", primary_contact_email: "some updated primary_contact_email", type: "some updated type", description: "some updated description", fpds_code: "some updated fpds_code", secondary_contact_email: "some updated secondary_contact_email", additional_info_link: "some updated additional_info_link", link: "some updated link", award_number: "some updated award_number", secondary_contact_fax: "some updated secondary_contact_fax", primary_contact_title: "some updated primary_contact_title", aac_code: "some updated aac_code", response_deadline: "some updated response_deadline", organization_type: "some updated organization_type", zip_code: "some updated zip_code", set_aside_code: "some updated set_aside_code", active: "some updated active", archive_date: "some updated archive_date", award: "some updated award", primary_contact_fullname: "some updated primary_contact_fullname", pop_city: "some updated pop_city", notice_id: "some updated notice_id", sub_tier: "some updated sub_tier", naics_code: "some updated naics_code", pop_country: "some updated pop_country", primary_contact_fax: "some updated primary_contact_fax", pop_street_address: "some updated pop_street_address", office: "some updated office", cgac: "some updated cgac", pop_state: "some updated pop_state", pop_zip: "some updated pop_zip", department_ind_agency: "some updated department_ind_agency", primary_contact_phone: "some updated primary_contact_phone", secondary_contact_phone: "some updated secondary_contact_phone", awardee: "some updated awardee"}

      assert {:ok, %SAMOpportunity{} = sam_opportunity} = Opportunities.update_sam_opportunity(sam_opportunity, update_attrs)
      assert sam_opportunity.awardee == "some updated awardee"
      assert sam_opportunity.secondary_contact_phone == "some updated secondary_contact_phone"
      assert sam_opportunity.primary_contact_phone == "some updated primary_contact_phone"
      assert sam_opportunity.department_ind_agency == "some updated department_ind_agency"
      assert sam_opportunity.pop_zip == "some updated pop_zip"
      assert sam_opportunity.pop_state == "some updated pop_state"
      assert sam_opportunity.cgac == "some updated cgac"
      assert sam_opportunity.office == "some updated office"
      assert sam_opportunity.pop_street_address == "some updated pop_street_address"
      assert sam_opportunity.primary_contact_fax == "some updated primary_contact_fax"
      assert sam_opportunity.pop_country == "some updated pop_country"
      assert sam_opportunity.naics_code == "some updated naics_code"
      assert sam_opportunity.sub_tier == "some updated sub_tier"
      assert sam_opportunity.notice_id == "some updated notice_id"
      assert sam_opportunity.pop_city == "some updated pop_city"
      assert sam_opportunity.primary_contact_fullname == "some updated primary_contact_fullname"
      assert sam_opportunity.award == "some updated award"
      assert sam_opportunity.archive_date == "some updated archive_date"
      assert sam_opportunity.active == "some updated active"
      assert sam_opportunity.set_aside_code == "some updated set_aside_code"
      assert sam_opportunity.zip_code == "some updated zip_code"
      assert sam_opportunity.organization_type == "some updated organization_type"
      assert sam_opportunity.response_deadline == "some updated response_deadline"
      assert sam_opportunity.aac_code == "some updated aac_code"
      assert sam_opportunity.primary_contact_title == "some updated primary_contact_title"
      assert sam_opportunity.secondary_contact_fax == "some updated secondary_contact_fax"
      assert sam_opportunity.award_number == "some updated award_number"
      assert sam_opportunity.link == "some updated link"
      assert sam_opportunity.additional_info_link == "some updated additional_info_link"
      assert sam_opportunity.secondary_contact_email == "some updated secondary_contact_email"
      assert sam_opportunity.fpds_code == "some updated fpds_code"
      assert sam_opportunity.description == "some updated description"
      assert sam_opportunity.type == "some updated type"
      assert sam_opportunity.primary_contact_email == "some updated primary_contact_email"
      assert sam_opportunity.secondary_contact_fullname == "some updated secondary_contact_fullname"
      assert sam_opportunity.title == "some updated title"
      assert sam_opportunity.posted_date == "some updated posted_date"
      assert sam_opportunity.award_date == "some updated award_date"
      assert sam_opportunity.base_type == "some updated base_type"
      assert sam_opportunity.sol == "some updated sol"
      assert sam_opportunity.city == "some updated city"
      assert sam_opportunity.classification_code == "some updated classification_code"
      assert sam_opportunity.archive_type == "some updated archive_type"
      assert sam_opportunity.secondary_contact_title == "some updated secondary_contact_title"
      assert sam_opportunity.set_aside == "some updated set_aside"
      assert sam_opportunity.state == "some updated state"
      assert sam_opportunity.country_code == "some updated country_code"
    end

    test "update_sam_opportunity/2 with invalid data returns error changeset" do
      sam_opportunity = sam_opportunity_fixture()
      assert {:error, %Ecto.Changeset{}} = Opportunities.update_sam_opportunity(sam_opportunity, @invalid_attrs)
      assert sam_opportunity == Opportunities.get_sam_opportunity!(sam_opportunity.id)
    end

    test "delete_sam_opportunity/1 deletes the sam_opportunity" do
      sam_opportunity = sam_opportunity_fixture()
      assert {:ok, %SAMOpportunity{}} = Opportunities.delete_sam_opportunity(sam_opportunity)
      assert_raise Ecto.NoResultsError, fn -> Opportunities.get_sam_opportunity!(sam_opportunity.id) end
    end

    test "change_sam_opportunity/1 returns a sam_opportunity changeset" do
      sam_opportunity = sam_opportunity_fixture()
      assert %Ecto.Changeset{} = Opportunities.change_sam_opportunity(sam_opportunity)
    end
  end
end
