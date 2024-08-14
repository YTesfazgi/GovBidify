defmodule GovBidifyWeb.HomeLive do
  use GovBidifyWeb, :live_view

  alias GovBidify.Opportunities

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, results: [], selected_opportunity: nil, drawer_visible: false)}
  end

  def handle_event("search", %{"query" => query}, socket) do
    results = Opportunities.search_opportunities_by_title_and_description(query)
    {:noreply, assign(socket, query: query, results: results)}
  end

  def handle_event("select_opportunity", %{"id" => notice_id}, socket) do
    opportunity = Opportunities.get_opportunity_by_notice_id!(notice_id)
    {:noreply, assign(socket, selected_opportunity: opportunity, drawer_visible: true)}
  end

  def handle_event("close_opportunity", _session, socket) do
    {:noreply, assign(socket, selected_opportunity: nil, drawer_visible: false)}
  end
end
