defmodule GovBidifyWeb.HomeLive do
  use GovBidifyWeb, :live_view

  alias GovBidify.Opportunities

  @selected_opportunity_nil %{title: nil, notice_id: nil, type: nil, department_ind_agency: nil, sub_tier: nil, office: nil, sol: nil, classification_code: nil, naics_code: nil, set_aside: nil, pop_street_address: nil, pop_city: nil, pop_state: nil, pop_zip: nil, pop_country: nil, posted_date: nil, response_deadline: nil, description: "", primary_contact_title: nil, primary_contact_fullname: nil, primary_contact_email: nil, primary_contact_phone: nil, primary_contact_fax: nil, secondary_contact_title: nil, secondary_contact_fullname: nil, secondary_contact_email: nil, secondary_contact_phone: nil, secondary_contact_fax: nil}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, results: [], selected_opportunity: @selected_opportunity_nil)}
  end

  def handle_event("search", %{"query" => query}, socket) do
    results = Opportunities.search_opportunities_by_title_and_description(query)
    {:noreply, assign(socket, query: query, results: results)}
  end

  def handle_event("select_opportunity", %{"id" => notice_id}, socket) do
    %{title: title, notice_id: notice_id, type: type, department_ind_agency: department_ind_agency, sub_tier: sub_tier, office: office, sol: sol, classification_code: classification_code, naics_code: naics_code, set_aside: set_aside, pop_street_address: pop_street_address, pop_city: pop_city, pop_state: pop_state, pop_zip: pop_zip, pop_country: pop_country, posted_date: posted_date, response_deadline: response_deadline, description: description, primary_contact_title: primary_contact_title, primary_contact_fullname: primary_contact_fullname, primary_contact_email: primary_contact_email, primary_contact_phone: primary_contact_phone, primary_contact_fax: primary_contact_fax, secondary_contact_title: secondary_contact_title, secondary_contact_fullname: secondary_contact_fullname, secondary_contact_email: secondary_email, secondary_contact_phone: secondary_contact_phone, secondary_contact_fax: secondary_contact_fax} = Opportunities.get_opportunity_by_notice_id!(notice_id)
    {:noreply, assign(socket, selected_opportunity: %{title: title, notice_id: notice_id, type: type, department_ind_agency: department_ind_agency, sub_tier: sub_tier, office: office, sol: sol, classification_code: classification_code, naics_code: naics_code, set_aside: set_aside, pop_street_address: pop_street_address, pop_city: pop_city, pop_state: pop_state, pop_zip: pop_zip, pop_country: pop_country, posted_date: posted_date, response_deadline: response_deadline, description: description, primary_contact_title: primary_contact_title, primary_contact_fullname: primary_contact_fullname, primary_contact_email: primary_contact_email, primary_contact_phone: primary_contact_phone, primary_contact_fax: primary_contact_fax, secondary_contact_title: secondary_contact_title, secondary_contact_fullname: secondary_contact_fullname, secondary_contact_email: secondary_email, secondary_contact_phone: secondary_contact_phone, secondary_contact_fax: secondary_contact_fax})}
  end
end
