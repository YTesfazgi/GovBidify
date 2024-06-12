defmodule GovBidify.Opportunities.OpportunityFactory do
  defmacro __using__(_opts) do
    quote do
      def opportunity_factory do
        %GovBidify.Opportunities.Opportunity{
          awardee: Faker.Company.En.name(),
          secondary_contact_phone: Faker.Phone.EnUs.phone(),
          primary_contact_phone: Faker.Phone.EnUs.phone(),
          department_ind_agency: "GENERAL SERVICES ADMINISTRATION",
          pop_zip: Faker.Address.En.zip_code(),
          pop_state: Faker.Address.En.state(),
          cgac: Faker.String.base64(),
          office: "PBS R00 Center for Broker Services",
          pop_street_address: Faker.Address.En.street_address(),
          primary_contact_fax: Faker.Phone.EnUs.phone(),
          pop_country: Faker.Address.En.country(),
          naics_code: Faker.String.base64(),
          sub_tier: "Public Buildings Service",
          notice_id: Faker.String.base64(),
          pop_city: Faker.Address.En.city(),
          primary_contact_fullname: Faker.Person.En.name(),
          award: "35000000.00", # this should be a float
          archive_date: Faker.Date.backward(300),
          active: "Yes",
          set_aside_code: "Total Small Business Set-Aside (FAR 19.5)",
          zip_code: Faker.Address.En.zip_code,
          organization_type: "some text",
          response_deadline: Faker.Date.forward(10),
          aac_code: Faker.String.base64(),
          primary_contact_title: Faker.Lorem.sentence(),
          secondary_contact_fax: Faker.Phone.EnUs.phone(),
          award_number: Faker.String.base64(),
          link: Faker.Internet.domain_name(),
          additional_info_link: Faker.Internet.domain_name(),
          secondary_contact_email: Faker.Internet.email(),
          fpds_code: Faker.String.base64(),
          description: Faker.Lorem.paragraph(),
          type: "Sources Sought",
          primary_contact_email: Faker.Internet.email(),
          secondary_contact_fullname: Faker.Person.En.name(),
          title: Faker.Lorem.sentence(),
          posted_date: Faker.Date.backward(300),
          award_date: Faker.Date.backward(30),
          base_type: "Sources Sought",
          sol: Faker.String.base64(),
          city: Faker.Address.En.city(),
          classification_code: Faker.String.base64(),
          archive_type: "auto15",
          secondary_contact_title: Faker.Lorem.sentence(),
          set_aside: "SBA",
          state: Faker.Address.En.state(),
          country_code: "USA"
        }
      end
    end
  end
end
