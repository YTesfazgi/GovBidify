defmodule GovBidifyWeb.HomeLive do
  use GovBidifyWeb, :live_view
  alias GovBidifyWeb.Filter
  alias GovBidify.Opportunities

  def mount(_params, _session, socket) do
    form = to_form(
      default_meta()
    )

    {:ok, assign(socket,
      form: form,
      results: [],
      meta: default_meta(),
      selected_opportunity: default_selected_opportunity(),
      combobox_options: combobox_options(),
      mobile_search_bar: true
    )}
  end

  def handle_event("search", params, socket) do
    IO.inspect(params, label: "params")
    cleaned_params = clean_params(params)
    IO.inspect(cleaned_params, label: "cleaned_params")
    socket = assign(socket, form: to_form(cleaned_params))
    {:noreply, push_patch(socket, to: ~p"/?#{cleaned_params}")}
  end

  def handle_event("select_opportunity", %{"id" => notice_id}, socket) do
    selected_opportunity = Opportunities.get_opportunity_by_notice_id!(notice_id)
    socket = assign(socket, selected_opportunity: selected_opportunity)
    {:noreply, push_event(socket, "open-drawer", %{})}
  end

  def handle_event("close_opportunity", _session, socket) do
    {:noreply, push_event(socket, "close-drawer", %{})}
  end

  def handle_params(%{"query" => query} = params, _uri, socket) do
    IO.inspect(params, label: "params")
    flop = case params do
      %{"order_by" => order_by, "order_directions" => order_directions, "page_size" => page_size, "filters" => filters} ->
        %{
          order_by: order_by,
          order_directions: order_directions,
          page_size: page_size,
          filters: filters,
          page: params["page"] || 1
        }
      _ ->
        %{
          order_by: ["response_deadline"],
          order_directions: ["asc"],
          page_size: 10,
          filters: %{},
          page: params["page"] || 1
        }
    end

    {results, meta} = Opportunities.search(query, flop)

    {:noreply,
      assign(socket,
        results: results,
        meta: meta,
        order_by: flop.order_by,
        order_directions: flop.order_directions,
        page_size: flop.page_size,
        filters: flop.filters,
        query: query
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
        value == [""] || value == [] || is_nil(value)
      end)
      |> Enum.into(%{})
    end)
    |> Enum.reject(fn {_key, value} ->
      value == "" || value == %{} || is_nil(value)
    end)
    |> Enum.into(%{})
  end

  defp default_flop do
    %Flop{
      page_size: 10,
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
        countries: Opportunities.list_countries(),
        states: Opportunities.list_states()
      }
    end)

    options
  end
end
