defmodule GovBidifyWeb.ContractAwardsLive.Index do
  use GovBidifyWeb, :live_view
  alias GovBidifyWeb.Filter
  alias GovBidifyWeb.SortMenu
  alias GovBidify.ContractAwards
  alias GovBidify.NAICS_Codes
  alias GovBidify.PSC_Codes
  alias GovBidify.Opportunities
  alias GovBidifyWeb.FlopDefaults

  def mount(_params, _session, socket) do
    form = to_form(FlopDefaults.contract_award_flop())

    {:ok, assign(socket,
      page_title: "Contract Awards",
      form: form,
      results: [],
      meta: FlopDefaults.contract_award_meta(),
      selected_contract_award: default_selected_contract_award(),
      drawer_visible: false,
      mobile_search_bar: true,
      show_filter_modal: false,
      combobox_options: combobox_options())}
  end

  def handle_event("search", params, socket) do
    # Merge new params with existing form data for mobile search
    current_form_data = socket.assigns.form.source
    merged_params = Map.merge(current_form_data, params)

    form = merged_params
    |> clean_params()
    |> to_form()

    updated_socket = assign(socket, form: form)

    {:noreply, push_patch(updated_socket, to: ~p"/contract_awards?#{clean_params(merged_params)}")}
  end

  def handle_event("select_contract_award", %{"id" => contract_transaction_unique_key}, socket) do
    {:noreply,
      socket
      |> assign(selected_contract_award: ContractAwards.get_contract_award_by_contract_transaction_unique_key!(contract_transaction_unique_key))
      |> push_event("open-drawer", %{})
    }
  end

  def handle_event("close_contract_award", _session, socket) do
    {:noreply, push_event(socket, "close-drawer", %{})}
  end

  def handle_event("open_filter_modal", _params, socket) do
    {:noreply, assign(socket, show_filter_modal: true)}
  end

  def handle_event("close_filter_modal", _params, socket) do
    {:noreply, assign(socket, show_filter_modal: false)}
  end

  def handle_params(%{"query" => query} = params, _uri, socket) do
    IO.inspect(query, label: "query")
    IO.inspect(params, label: "params")

    form = params
      |> clean_params()
      |> to_form()

    {results, meta} = ContractAwards.search(query, params)

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

  defp default_selected_contract_award do
    %{
      award_id_piid: nil,
      solicitation_identifier: nil,
      award_type: nil,
      usaspending_permalink: nil,
      transaction_description: "No description available",
      awarding_agency_name: "No agency available",
      awarding_sub_agency_name: "No sub-agency available",
      awarding_office_name: "No office available",
      type_of_set_aside: "No set-aside available",
      naics_code: "No NAICS code available",
      naics_description: "No NAICS description available",
      type_of_set_aside_code: "No set-aside code available",
      action_date: nil,
      last_modified_date: nil
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
