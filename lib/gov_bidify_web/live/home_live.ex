defmodule GovBidifyWeb.HomeLive do
  use GovBidifyWeb, :live_view

  alias GovBidify.Opportunities

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, results: [])}
  end

  def handle_event("search", %{"query" => query}, socket) do
    IO.inspect(query, label: "query")
    results = Opportunities.search_opportunities_by_title_and_description(query)
    IO.inspect(results, label: "results")

    {:noreply, assign(socket, query: query, results: results)}
  end
end
