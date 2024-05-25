defmodule GovBidifyWeb.HomeLive do
  use GovBidifyWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: [])}
  end

  def handle_event("search", %{"query" => query}, socket) do
    results = perform_search(query)
    {:noreply, assign(socket, query: query, results: results)}
  end

  defp perform_search(query) do
    # Mocking search results
    [
      %{title: "Result 1 for #{query}", url: "https://example.com/1"},
      %{title: "Result 2 for #{query}", url: "https://example.com/2"},
      %{title: "Result 3 for #{query}", url: "https://example.com/3"}
    ]
  end
end
