defmodule GovBidify.OpportunitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GovBidify.Opportunities` context.
  """

  @doc """
  Generate a sam_opportunity.
  """
  def sam_opportunity_fixture(attrs \\ %{}) do
    {:ok, sam_opportunity} =
      attrs
      |> Enum.into(%{
        aac_code: "some aac_code",
        active: "some active",
        additional_info_link: "some additional_info_link",
        archive_date: "some archive_date",
        archive_type: "some archive_type",
        award: "some award",
        award_date: "some award_date",
        award_number: "some award_number",
        awardee: "some awardee",
        base_type: "some base_type",
        cgac: "some cgac",
        city: "some city",
        classification_code: "some classification_code",
        country_code: "some country_code",
        department_ind_agency: "some department_ind_agency",
        description: "some description",
        fpds_code: "some fpds_code",
        link: "some link",
        naics_code: "some naics_code",
        notice_id: "some notice_id",
        office: "some office",
        organization_type: "some organization_type",
        pop_city: "some pop_city",
        pop_country: "some pop_country",
        pop_state: "some pop_state",
        pop_street_address: "some pop_street_address",
        pop_zip: "some pop_zip",
        posted_date: "some posted_date",
        primary_contact_email: "some primary_contact_email",
        primary_contact_fax: "some primary_contact_fax",
        primary_contact_fullname: "some primary_contact_fullname",
        primary_contact_phone: "some primary_contact_phone",
        primary_contact_title: "some primary_contact_title",
        response_deadline: "some response_deadline",
        secondary_contact_email: "some secondary_contact_email",
        secondary_contact_fax: "some secondary_contact_fax",
        secondary_contact_fullname: "some secondary_contact_fullname",
        secondary_contact_phone: "some secondary_contact_phone",
        secondary_contact_title: "some secondary_contact_title",
        set_aside: "some set_aside",
        set_aside_code: "some set_aside_code",
        sol: "some sol",
        state: "some state",
        sub_tier: "some sub_tier",
        title: "some title",
        type: "some type",
        zip_code: "some zip_code"
      })
      |> GovBidify.Opportunities.create_sam_opportunity()

    sam_opportunity
  end
end
