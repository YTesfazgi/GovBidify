defmodule GovBidifyWeb.OpportunitiesLive.Index do
  use GovBidifyWeb, :live_view
  alias GovBidifyWeb.Filter
  alias GovBidifyWeb.SortMenu
  alias GovBidify.Opportunities
  alias GovBidify.NAICS_Codes
  alias GovBidify.PSC_Codes
  alias GovBidifyWeb.FlopDefaults

  def mount(_params, _session, socket) do
    form = to_form(FlopDefaults.opportunity_flop())

    {:ok, assign(socket,
      page_title: "Opportunities",
      form: form,
      results: [],
      meta: FlopDefaults.opportunity_meta(),
      selected_opportunity: default_selected_opportunity(),
      combobox_options: combobox_options(),
      mobile_search_bar: true,
      show_filter_modal: false
    )}
  end

  def handle_event("search", params, socket) do
    # Merge new params with existing form data for mobile search
    current_form_data = socket.assigns.form.source
    merged_params = Map.merge(current_form_data, params)

    form = merged_params
    |> clean_params()
    |> to_form()

    updated_socket = assign(socket, form: form)

    {:noreply, push_patch(updated_socket, to: ~p"/opportunities/?#{clean_params(merged_params)}")}
  end

  def handle_event("select_opportunity", %{"id" => notice_id}, socket) do
    opportunity = Opportunities.get_opportunity_by_notice_id!(notice_id)

    # IO.inspect(opportunity, label: "opportunity")

    related_contract_awards = GovBidify.ContractAwards.get_related_contract_awards(opportunity)

    IO.inspect(related_contract_awards, label: "related_contract_awards")

    {:noreply,
      socket
      |> assign(selected_opportunity: Opportunities.get_opportunity_by_notice_id!(notice_id))
      |> push_event("open-drawer", %{})
    }
  end

  def handle_event("close_opportunity", _session, socket) do
    {:noreply, push_event(socket, "close-drawer", %{})}
  end

  def handle_event("open_filter_modal", _params, socket) do
    {:noreply, assign(socket, show_filter_modal: true)}
  end

  def handle_event("close_filter_modal", _params, socket) do
    {:noreply, assign(socket, show_filter_modal: false)}
  end

  def handle_params(%{"query" => query} = params, _uri, socket) do
    form = params
      |> clean_params()
      |> to_form()

    {results, meta} = Opportunities.search(query, params)

    {:noreply,
      assign(socket,
        results: results,
        meta: meta,
        form: form
      )
    }
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  defp clean_params(params) do
    params
    |> Map.delete("_target")
    |> Map.update("filters", %{}, fn filters ->
      filters
      |> Enum.reject(fn {_key, value} ->
        value == [""] || value == [] || is_nil(value) || value == ""
      end)
      |> Enum.into(%{})
    end)
    |> Enum.reject(fn {_key, value} ->
      case value do
        "" -> true
        %{} -> Enum.empty?(value)
        nil -> true
        [""] -> true
        [] -> true
        _ -> false
      end
    end)
    |> Enum.into(%{})
  end

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
    {_, options} = Cachex.fetch(:combobox_cache, :combobox_options, fn ->
      %{
        types: Opportunities.list_types(),
        departments: Opportunities.list_departments(),
        sub_tiers: Opportunities.list_sub_tiers(),
        offices: Opportunities.list_offices(),
        set_asides: Opportunities.list_set_asides(),
        naics_codes: NAICS_Codes.list_naics_codes(),
        psc_codes: PSC_Codes.list_psc_codes(),
        countries: Opportunities.list_countries(),
        states: Opportunities.list_states()
      }
    end)

    options
  end
end
