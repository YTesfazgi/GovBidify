defmodule GovBidifyWeb.ContractAwardsLive.Index do
  use GovBidifyWeb, :live_view

  alias GovBidify.ContractAwards

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, results: [], selected_contract: nil, drawer_visible: false)}
  end

  def handle_event("search", %{"query" => query}, socket) do
    results = ContractAwards.search_contract_awards_by_description(query)
    {:noreply, assign(socket, query: query, results: results)}
  end

  def handle_event("select_contract", %{"id" => contract_transaction_unique_key}, socket) do
    contract = ContractAwards.get_contract_award_by_contract_transaction_unique_key!(contract_transaction_unique_key)
    {:noreply, assign(socket, selected_contract: contract, drawer_visible: true)}
  end

  def handle_event("close_contract", _session, socket) do
    {:noreply, assign(socket, selected_contract: nil, drawer_visible: false)}
  end
end
