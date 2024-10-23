defmodule GovBidifyWeb.Combobox do
  use GovBidifyWeb, :live_component

  attr :id, :string, required: true
  attr :label, :string, required: true
  attr :placeholder, :string, default: "Search..."
  attr :options, :list, required: true
  attr :selected_options_id, :string, required: true
  attr :value, :list, default: []

  def render(assigns) do
    ~H"""
    <div class="w-full py-3">
      <label for={"#{@id}-combobox"} class="block text-sm font-medium leading-6 text-gray-900"><%= @label %></label>
      <div class="relative mt-2">
        <input
          id={"#{@id}-combobox"}
          type="text"
          class="w-full rounded-md border-0 bg-white py-1.5 pl-3 pr-12 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-green-600 sm:text-sm sm:leading-6"
          role="combobox"
          aria-controls={"#{@id}-options"}
          aria-expanded="false"
          placeholder={@placeholder}
          value={@value}
        >
        <button type="button" class="absolute inset-y-0 right-0 flex items-center rounded-r-md px-2 focus:outline-none">
          <svg class="h-5 w-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M10 3a.75.75 0 01.55.24l3.25 3.5a.75.75 0 11-1.1 1.02L10 4.852 7.3 7.76a.75.75 0 01-1.1-1.02l3.25-3.5A.75.75 0 0110 3zm-3.76 9.2a.75.75 0 011.06.04l2.7 2.908 2.7-2.908a.75.75 0 111.1 1.02l-3.25 3.5a.75.75 0 01-1.1 0l-3.25-3.5a.75.75 0 01.04-1.06z" clip-rule="evenodd" />
          </svg>
        </button>
        <ul class="absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md bg-white py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none sm:text-sm hidden" id={"#{@id}-options"} role="listbox">
          <%= for option <- @options do %>
            <li class="relative cursor-default select-none py-2 pl-8 pr-4 text-gray-900 hover:bg-gray-100 hover:text-gray-900" role="option" tabindex="0">
              <span class="block"><%= option %></span>
              <span class="absolute inset-y-0 left-0 flex items-center pl-1.5 text-green-600 hidden checkmark">
                <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                  <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clip-rule="evenodd" />
                </svg>
              </span>
            </li>
          <% end %>
        </ul>
      </div>
      <div id={@selected_options_id} class="mt-2 flex flex-wrap gap-2"></div>
    </div>
    """
  end
end
