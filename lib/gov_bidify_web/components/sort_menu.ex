defmodule GovBidifyWeb.SortMenu do
  use GovBidifyWeb, :live_component

  # You can add a type spec for better documentation
  @type button :: {String.t(), String.t()}

  def render(assigns) do
    ~H"""
    <div id="sort-menu"
         class="absolute right-0 z-10 mt-2 w-40 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none transform transition-all ease-out duration-150 opacity-0 scale-95 hidden"
         role="menu"
         aria-orientation="vertical"
         aria-labelledby="menu-button"
         tabindex="-1">
      <div class="py-1" role="none">
        <%= for {label, value} <- @buttons do %>
          <button name="order_by[]"
                  value={value}
                  class="block w-full text-left px-4 py-2 text-sm text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                  role="menuitem"
                  tabindex="-1">
            <%= label %>
          </button>
        <% end %>
      </div>
    </div>
    """
  end
end
