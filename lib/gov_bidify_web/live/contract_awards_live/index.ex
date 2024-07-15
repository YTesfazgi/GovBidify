defmodule GovBidifyWeb.ContractAwardsLive.Index do
  use GovBidifyWeb, :live_view

  alias GovBidify.ContractAwards

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, results: [], selected_contract: nil)}
  end

  def handle_event("search", %{"query" => query}, socket) do
    results = ContractAwards.search_contract_awards_by_description(query)
    {:noreply, assign(socket, query: query, results: results)}
  end

  def handle_event("select_contract", %{"award_id_piid" => award_id_piid}, socket) do
    contract = ContractAwards.get_contract_award_by_award_id_piid!(award_id_piid)
    {:noreply, assign(socket, selected_contract: contract)}
  end
end
