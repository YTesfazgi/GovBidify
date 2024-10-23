defmodule GovBidifyWeb.HomeLive do
  use GovBidifyWeb, :live_view

  alias GovBidify.Opportunities

  def mount(_params, _session, socket) do
    {:ok, assign(socket, order_by: ["response_deadline"], order_directions: ["asc"], limit: 10, filters: %{type: [], department: [], sub_tier: [], office: [], country: [], state: [], city: []}, query: nil, results: [], meta: default_meta(), selected_opportunity: default_selected_opportunity(), combobox_options: combobox_options(), mobile_search_bar: true)}
  end

  def handle_event("update_filters", %{"filters" => filters}, socket) do
    IO.inspect(filters, label: "filter params")
    IO.inspect(socket.assigns.filters, label: "socket filters")
    {:noreply, assign(socket, filters: filters)}
  end

  def handle_event("select_opportunity", %{"id" => notice_id}, socket) do
    selected_opportunity = Opportunities.get_opportunity_by_notice_id!(notice_id)
    socket = assign(socket, selected_opportunity: selected_opportunity)
    {:noreply, push_event(socket, "open-drawer", %{})}
  end

  def handle_event("close_opportunity", _session, socket) do
    {:noreply, push_event(socket, "close-drawer", %{})}
  end

  def handle_params(%{"query" => query, "flop" => %{"order_by" => order_by, "order_directions" => order_directions, "limit" => limit, "filters" => filters}} = params, _uri, socket) do
    IO.inspect(params, label: "params")
    # Check if the query has changed
    if query != socket.assigns.query do
      flop = %{order_by: order_by, order_directions: order_directions, limit: limit, filters: Jason.decode!(filters)}
      {results, meta} = Opportunities.search_opportunities_by_title_and_description(query, flop)

      {:noreply,
        assign(socket,
          results: results,
          meta: meta,
          query: query
        )
      }
    else
      {:noreply}  # No change in query, return the existing socket
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def filter_section(assigns) do
    ~H"""
    <div class="w-full border-b border-gray-200 py-6">
      <h3 class="-my-3 flow-root">
        <button
          type="button"
          id={"#{@id}-filter-section-button"}
          phx-click={JS.toggle(to: "#filter-section-#{@id}")
            |> JS.toggle(to: "#expand-icon-#{@id}")
            |> JS.toggle(to: "#collapse-icon-#{@id}")}
          class="flex w-full items-center justify-between bg-white py-3 text-sm text-gray-400 hover:text-gray-500"
          aria-controls={"filter-section-#{@id}"}
          aria-expanded="false"
        >
          <span class="font-medium text-gray-900"><%= @title %></span>
          <span class="ml-6 flex items-center">
            <svg id={"expand-icon-#{@id}"} class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path d="M10.75 4.75a.75.75 0 00-1.5 0v4.5h-4.5a.75.75 0 000 1.5h4.5v4.5a.75.75 0 001.5 0v-4.5h4.5a.75.75 0 000-1.5h-4.5v-4.5z" />
            </svg>
            <svg id={"collapse-icon-#{@id}"} class="hidden h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path fill-rule="evenodd" d="M4 10a.75.75 0 01.75-.75h10.5a.75.75 0 010 1.5H4.75A.75.75 0 014 10z" clip-rule="evenodd" />
            </svg>
          </span>
        </button>
      </h3>
      <div
        id={"filter-section-#{@id}"}
        class="hidden pt-6 w-full"
        phx-update="ignore"
      >
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp default_flop do
    %Flop{
      limit: 10,
      order_by: ["response_deadline"],
      order_directions: ["asc"],
      filters: %{}
    }
  end

  defp default_meta do
    %Flop.Meta{
      flop: default_flop(),
      has_next_page?: false,
      has_previous_page?: false,
      next_page: nil,
      previous_page: nil
    }
  end

  # defp default_selected_filters do
  #   %{
  #     type: ["Sources Sought"],
  #     active: ["Yes"]
  #   }
  # end

  defp default_selected_opportunity do
    %{
      title: nil,
      notice_id: nil,
      type: nil,
      department_ind_agency: nil,
      sub_tier: nil,
      office: nil,
      sol: nil,
      classification_code: nil,
      naics_code: nil,
      set_aside: nil,
      pop_street_address: nil,
      pop_city: nil,
      pop_state: nil,
      pop_zip: nil,
      pop_country: nil,
      posted_date: nil,
      response_deadline: nil,
      description: "",
      primary_contact_title: nil,
      primary_contact_fullname: nil,
      primary_contact_email: nil,
      primary_contact_phone: nil,
      primary_contact_fax: nil,
      secondary_contact_title: nil,
      secondary_contact_fullname: nil,
      secondary_contact_email: nil,
      secondary_contact_phone: nil,
      secondary_contact_fax: nil,
      link: nil,
      active: nil
    }
  end

  defp combobox_options do
    %{
      types: Opportunities.list_types(),
      departments: Opportunities.list_departments(),
      sub_tiers: Opportunities.list_sub_tiers(),
      offices: Opportunities.list_offices(),
      countries: Opportunities.list_countries(),
      states: Opportunities.list_states()
    }
  end
end
