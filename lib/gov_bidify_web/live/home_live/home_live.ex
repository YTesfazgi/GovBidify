defmodule GovBidifyWeb.HomeLive do
  use GovBidifyWeb, :live_view

  alias GovBidify.Opportunities

  @selected_opportunity_nil %{title: nil, notice_id: nil, type: nil, department_ind_agency: nil, sub_tier: nil, office: nil, sol: nil, classification_code: nil, naics_code: nil, set_aside: nil, pop_street_address: nil, pop_city: nil, pop_state: nil, pop_zip: nil, pop_country: nil, posted_date: nil, response_deadline: nil, description: "", primary_contact_title: nil, primary_contact_fullname: nil, primary_contact_email: nil, primary_contact_phone: nil, primary_contact_fax: nil, secondary_contact_title: nil, secondary_contact_fullname: nil, secondary_contact_email: nil, secondary_contact_phone: nil, secondary_contact_fax: nil, link: nil, active: nil}
  @meta_default %{page: 1, page_size: 10, has_next_page?: false, next_page: nil, has_previous_page?: false, previous_page: nil}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, results: [], meta: @meta_default, selected_opportunity: @selected_opportunity_nil, order_by: "response_deadline", order_directions: "asc", mobile_search_bar: true)}
  end

  def handle_event("search", %{"query" => query}, socket) do
    {:noreply, push_patch(socket, to: ~p"/?query=#{URI.encode(query)}")}
  end

  def handle_event("select_opportunity", %{"id" => notice_id}, socket) do
    %{title: title, notice_id: notice_id, type: type, department_ind_agency: department_ind_agency, sub_tier: sub_tier, office: office, sol: sol, classification_code: classification_code, naics_code: naics_code, set_aside: set_aside, pop_street_address: pop_street_address, pop_city: pop_city, pop_state: pop_state, pop_zip: pop_zip, pop_country: pop_country, posted_date: posted_date, response_deadline: response_deadline, description: description, primary_contact_title: primary_contact_title, primary_contact_fullname: primary_contact_fullname, primary_contact_email: primary_contact_email, primary_contact_phone: primary_contact_phone, primary_contact_fax: primary_contact_fax, secondary_contact_title: secondary_contact_title, secondary_contact_fullname: secondary_contact_fullname, secondary_contact_email: secondary_email, secondary_contact_phone: secondary_contact_phone, secondary_contact_fax: secondary_contact_fax, link: link, active: active} = Opportunities.get_opportunity_by_notice_id!(notice_id)
    socket = assign(socket, selected_opportunity: %{title: title, notice_id: notice_id, type: type, department_ind_agency: department_ind_agency, sub_tier: sub_tier, office: office, sol: sol, classification_code: classification_code, naics_code: naics_code, set_aside: set_aside, pop_street_address: pop_street_address, pop_city: pop_city, pop_state: pop_state, pop_zip: pop_zip, pop_country: pop_country, posted_date: posted_date, response_deadline: response_deadline, description: description, primary_contact_title: primary_contact_title, primary_contact_fullname: primary_contact_fullname, primary_contact_email: primary_contact_email, primary_contact_phone: primary_contact_phone, primary_contact_fax: primary_contact_fax, secondary_contact_title: secondary_contact_title, secondary_contact_fullname: secondary_contact_fullname, secondary_contact_email: secondary_email, secondary_contact_phone: secondary_contact_phone, secondary_contact_fax: secondary_contact_fax, link: link, active: active})
    {:noreply, push_event(socket, "open-drawer", %{})}
  end

  def handle_event("close_opportunity", _session, socket) do
    {:noreply, push_event(socket, "close-drawer", %{})}
  end

  def handle_params(%{"query" => _query} = params, _uri, socket) do
    query = Map.get(params, "query", "")
    order_by = Map.get(params, "order_by", ["title"])
    order_directions = Map.get(params, "order_directions", ["asc"])
    page = Map.get(params, "page", "1") |> String.to_integer()
    page_size = Map.get(params, "page_size", "10") |> String.to_integer()

    flop_params = %{
      "page" => page,
      "page_size" => page_size,
      "order_by" => order_by,
      "order_directions" => order_directions
    }

    {results, meta} = Opportunities.search_opportunities_by_title_and_description(query, flop_params)

    {:noreply,
      assign(socket,
        results: results,
        meta: meta,
        flop: flop_params,
        order_by: order_by,
        order_directions: order_directions,
        query: query
      )
    }
  end


  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end
end
