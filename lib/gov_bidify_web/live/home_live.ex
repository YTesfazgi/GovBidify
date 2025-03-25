defmodule GovBidifyWeb.HomeLive do
  use GovBidifyWeb, :live_view

  # Use the on_mount lifecycle hook to ensure authentication
  on_mount {GovBidifyWeb.UserAuth, :ensure_authenticated}

  def render(assigns) do
    ~H"""
    <div class="py-10">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div class="text-center">
          <h1 class="text-4xl font-bold tracking-tight text-gray-900 sm:text-5xl">Welcome to GovBidify</h1>
          <p class="mt-6 text-lg leading-8 text-gray-600">
            You are logged in as <%= @current_user.email %>
          </p>
          <div class="mt-10 flex items-center justify-center gap-x-6">
            <a href={~p"/opportunities"} class="rounded-md bg-blue-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600">
              View Opportunities
            </a>
            <a href={~p"/contract_awards"} class="text-sm font-semibold leading-6 text-gray-900">
              Contract Awards <span aria-hidden="true">→</span>
            </a>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :mobile_search_bar, false)}
  end
end
