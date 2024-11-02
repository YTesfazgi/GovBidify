defmodule GovBidifyWeb.Filter do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  attr :id, :string, required: true
  attr :title, :string, required: true

  def section(assigns) do
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
end
