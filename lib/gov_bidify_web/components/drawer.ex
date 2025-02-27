defmodule GovBidifyWeb.Drawer do
  use GovBidifyWeb, :live_component

  def render(%{resource: "opportunity"} = assigns) do
    ~H"""
    <div class="relative z-10" role="dialog" aria-modal="true">
      <!-- Background backdrop, show/hide based on slide-over state. -->
      <div class="fixed"></div>

      <div class="fixed overflow-hidden">
        <div class="absolute overflow-hidden">
          <div class="pointer-events-none fixed inset-y-0 mt-16 lg:ml-72 right-0 flex max-w-full">
            <!-- Slide-over panel, show/hide based on slide-over state. -->
            <div phx-hook="DrawerHook" id="drawer" class="pointer-events-auto w-full md:max-w-lg lg:w-screen transform transition ease-in-out duration-500 sm:duration-700 translate-x-full">
              <form class="flex h-full flex-col bg-white shadow-xl">
                <div class="h-0 flex-1 overflow-y-auto">
                  <div class="bg-brand px-4 py-6 sm:px-6">
                    <div class="flex items-center justify-between">
                      <h2 class="text-base font-semibold leading-6 text-white"><%= @selected_opportunity.title %></h2>
                      <div class="ml-3 flex h-7 items-center">
                        <button phx-click="close_opportunity" type="button" class="relative rounded-md bg-brand text-white hover:text-white focus:outline-none focus:ring-2 focus:ring-white">
                          <span class="absolute -inset-2.5"></span>
                          <span class="sr-only">Close panel</span>
                          <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                          </svg>
                        </button>
                      </div>
                    </div>
                    <div class="mt-1">
                      <p class="text-sm text-white">Notice ID: <%= @selected_opportunity.notice_id %></p>
                      <p class="text-sm text-white"><%= @selected_opportunity.type %></p>
                    </div>
                  </div>
                  <div class="flex flex-1 flex-col justify-between">
                    <div class="divide-y divide-gray-200 px-4 sm:px-6">
                      <div class="space-y-6 pb-5 pt-6">
                        <div>
                          <label for="general-info" class="block text-base font-medium leading-6 text-gray-900">General Info</label>
                          <div>
                            <div class="mt-2">
                              <div class="flex flex-wrap gap-0">
                                <p class="w-1/2 text-sm font-medium">Posted Date</p>
                                <p class="w-1/2 text-sm font-medium">Response Deadline</p>
                                <p class="w-1/2 text-sm font-normal text-gray-600"><%= GovBidifyWeb.HomeLiveHTML.date_formatter(@selected_opportunity.posted_date) %></p>
                                <p class="w-1/2 text-sm font-normal text-gray-600"><%= GovBidifyWeb.HomeLiveHTML.datetime_handler(@selected_opportunity.response_deadline, "", ", ") %></p>
                              </div>
                            </div>
                          </div>
                          <div class="mt-4">
                            <div class="flex flex-wrap gap-0">
                              <p class="w-1/2 text-sm font-medium">Set Aside</p>
                              <p class="w-1/2 text-sm font-medium">Place of Performance</p>
                              <p class="w-1/2 text-sm font-normal text-gray-600"><%= @selected_opportunity.set_aside %></p>
                              <div class="w-1/2 text-sm font-normal text-gray-600">
                              <p><%= @selected_opportunity.pop_street_address %></p>
                              <p>
                                <%= GovBidifyWeb.HomeLiveHTML.pop_handler(@selected_opportunity.pop_city, @selected_opportunity.pop_state, @selected_opportunity.pop_zip, @selected_opportunity.pop_country) %>
                              </p>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div>
                          <label for="classification" class="block text-base font-medium leading-6 text-gray-900">Classification</label>
                          <div class="mt-2">
                            <div class="flex flex-wrap gap-0">
                              <p class="w-1/3 text-sm font-medium">Department/Ind. Agency</p>
                              <p class="w-1/3 text-sm font-medium">Sub-tier</p>
                              <p class="w-1/3 text-sm font-medium">Office</p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_opportunity.department_ind_agency %></p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_opportunity.sub_tier %></p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_opportunity.office %></p>
                            </div>
                          </div>
                        </div>
                        <div>
                          <div class="mt-2">
                            <div class="flex flex-wrap gap-0">
                              <p class="w-1/3 text-sm font-medium">Solicitation</p>
                              <p class="w-1/3 text-sm font-medium">Classification Code</p>
                              <p class="w-1/3 text-sm font-medium">NAICS</p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_opportunity.sol %></p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_opportunity.classification_code %></p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_opportunity.naics_code %></p>
                            </div>
                          </div>
                        </div>
                        <div>
                          <label for="description" class="block text-base font-medium leading-6 text-gray-900">Description</label>
                          <div class="mt-2">
                            <p class="text-sm font-normal break-words text-gray-600"><%= GovBidifyWeb.HomeLiveHTML.remove_replacement_symbol(@selected_opportunity.description) %></p>
                          </div>
                        </div>
                        <div>
                          <label for="contact-info" class="block text-base font-medium leading-6 text-gray-900">Contact Info</label>
                          <div class="mt-2">
                            <div class="flex flex-wrap gap-0">
                              <p class="w-1/2 text-sm font-medium">Primary</p>
                              <p class="w-1/2 text-sm font-medium">Secondary</p>
                              <div class="w-1/2 text-sm font-normal text-gray-600">
                                <p><%= @selected_opportunity.primary_contact_title %></p>
                                <p><%= @selected_opportunity.primary_contact_fullname %></p>
                                <p><%= @selected_opportunity.primary_contact_email %></p>
                                <p><%= @selected_opportunity.primary_contact_phone %></p>
                                <p><%= @selected_opportunity.primary_contact_fax %></p>
                              </div>
                              <div class="w-1/2 text-sm font-normal text-gray-600">
                                <p><%= @selected_opportunity.secondary_contact_title %></p>
                                <p><%= @selected_opportunity.secondary_contact_fullname %></p>
                                <p><%= @selected_opportunity.secondary_contact_email %></p>
                                <p><%= @selected_opportunity.secondary_contact_phone %></p>
                                <p><%= @selected_opportunity.secondary_contact_fax %></p>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="pb-6 pt-4">
                        <div class="flex text-sm">
                          <a href={@selected_opportunity.link} class="group inline-flex items-center font-medium text-brand hover:text-hovergreen">
                            <svg class="h-5 w-5 text-brand group-hover:text-hovergreen" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                              <path d="M12.232 4.232a2.5 2.5 0 013.536 3.536l-1.225 1.224a.75.75 0 001.061 1.06l1.224-1.224a4 4 0 00-5.656-5.656l-3 3a4 4 0 00.225 5.865.75.75 0 00.977-1.138 2.5 2.5 0 01-.142-3.667l3-3z" />
                              <path d="M11.603 7.963a.75.75 0 00-.977 1.138 2.5 2.5 0 01.142 3.667l-3 3a2.5 2.5 0 01-3.536-3.536l1.225-1.224a.75.75 0 00-1.061-1.06l-1.224 1.224a4 4 0 105.656 5.656l3-3a4 4 0 00-.225-5.865z" />
                            </svg>
                            <span class="ml-2">Copy link</span>
                          </a>
                        </div>
                        <div class="mt-4 flex text-sm">
                          <a href="#" class="group inline-flex items-center text-gray-500 hover:text-gray-900">
                            <svg class="h-5 w-5 text-gray-400 group-hover:text-gray-500" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zM8.94 6.94a.75.75 0 11-1.061-1.061 3 3 0 112.871 5.026v.345a.75.75 0 01-1.5 0v-.5c0-.72.57-1.172 1.081-1.287A1.5 1.5 0 108.94 6.94zM10 15a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
                            </svg>
                            <span class="ml-2">Learn more about sharing</span>
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="flex flex-shrink-0 justify-end px-4 py-4">
                  <button type="button" class="rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">Cancel</button>
                  <button phx-click="add_to_pursuits" phx-value-id={@selected_opportunity.notice_id} class="ml-4 inline-flex justify-center rounded-md bg-brand px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-hovergreen focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand">Add to Pursuits</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def render(%{resource: "contract_award"} = assigns) do
    ~H"""
    <div class="relative z-10" role="dialog" aria-modal="true">
      <!-- Background backdrop, show/hide based on slide-over state. -->
      <div class="fixed"></div>

      <div class="fixed overflow-hidden">
        <div class="absolute overflow-hidden">
          <div class="pointer-events-none fixed inset-y-0 mt-16 lg:ml-72 right-0 flex max-w-full">
            <!-- Slide-over panel, show/hide based on slide-over state. -->
            <div phx-hook="DrawerHook" id="drawer" class="pointer-events-auto w-full md:max-w-lg lg:w-screen transform transition ease-in-out duration-500 sm:duration-700 translate-x-full">
              <form class="flex h-full flex-col bg-white shadow-xl">
                <div class="h-0 flex-1 overflow-y-auto">
                  <div class="bg-brand px-4 py-6 sm:px-6">
                    <div class="flex items-center justify-between">
                      <h2 class="text-base font-semibold leading-6 text-white"><%= @selected_contract_award.award_id_piid %></h2>
                      <div class="ml-3 flex h-7 items-center">
                        <button phx-click="close_contract_award" type="button" class="relative rounded-md bg-brand text-white hover:text-white focus:outline-none focus:ring-2 focus:ring-white">
                          <span class="absolute -inset-2.5"></span>
                          <span class="sr-only">Close panel</span>
                          <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                          </svg>
                        </button>
                      </div>
                    </div>
                    <div class="mt-1">
                      <p class="text-sm text-white">Solicitation ID: <%= @selected_contract_award.solicitation_identifier %></p>
                      <p class="text-sm text-white"><%= @selected_contract_award.award_type %></p>
                    </div>
                  </div>
                  <div class="flex flex-1 flex-col justify-between">
                    <div class="divide-y divide-gray-200 px-4 sm:px-6">
                      <div class="space-y-6 pb-5 pt-6">
                        <div>
                          <label for="general-info" class="block text-base font-medium leading-6 text-gray-900">General Info</label>
                          <div>
                            <div class="mt-2">
                              <div class="flex flex-wrap gap-0">
                                <p class="w-1/2 text-sm font-medium">Posted Date</p>
                                <p class="w-1/2 text-sm font-medium">Response Deadline</p>
                                <%!-- <p class="w-1/2 text-sm font-normal text-gray-600"><%= GovBidifyWeb.HomeLiveHTML.date_formatter(@selected_contract_award.posted_date) %></p>
                                <p class="w-1/2 text-sm font-normal text-gray-600"><%= GovBidifyWeb.HomeLiveHTML.datetime_handler(@selected_contract_award.response_deadline, "", ", ") %></p> --%>
                              </div>
                            </div>
                          </div>
                          <div class="mt-4">
                            <div class="flex flex-wrap gap-0">
                              <p class="w-1/2 text-sm font-medium">Set Aside</p>
                              <p class="w-1/2 text-sm font-medium">Place of Performance</p>
                              <%!-- <p class="w-1/2 text-sm font-normal text-gray-600"><%= @selected_contract_award.set_aside %></p> --%>
                              <div class="w-1/2 text-sm font-normal text-gray-600">
                              <%!-- <p><%= @selected_contract_award.pop_street_address %></p> --%>
                              <p>
                                <%!-- <%= GovBidifyWeb.HomeLiveHTML.pop_handler(@selected_contract_award.pop_city, @selected_contract_award.pop_state, @selected_contract_award.pop_zip, @selected_contract_award.pop_country) %> --%>
                              </p>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div>
                          <label for="classification" class="block text-base font-medium leading-6 text-gray-900">Classification</label>
                          <div class="mt-2">
                            <div class="flex flex-wrap gap-0">
                              <p class="w-1/3 text-sm font-medium">Department/Ind. Agency</p>
                              <p class="w-1/3 text-sm font-medium">Sub-tier</p>
                              <p class="w-1/3 text-sm font-medium">Office</p>
                              <%!-- <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_contract_award.department_ind_agency %></p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_contract_award.sub_tier %></p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_contract_award.office %></p> --%>
                            </div>
                          </div>
                        </div>
                        <div>
                          <div class="mt-2">
                            <div class="flex flex-wrap gap-0">
                              <p class="w-1/3 text-sm font-medium">Solicitation</p>
                              <p class="w-1/3 text-sm font-medium">Classification Code</p>
                              <p class="w-1/3 text-sm font-medium">NAICS</p>
                              <%!-- <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_contract_award.sol %></p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_contract_award.classification_code %></p>
                              <p class="w-1/3 text-sm font-normal text-gray-600"><%= @selected_contract_award.naics_code %></p> --%>
                            </div>
                          </div>
                        </div>
                        <div>
                          <label for="description" class="block text-base font-medium leading-6 text-gray-900">Description</label>
                          <div class="mt-2">
                            <%!-- <p class="text-sm font-normal break-words text-gray-600"><%= GovBidifyWeb.HomeLiveHTML.remove_replacement_symbol(@selected_contract_award.description) %></p> --%>
                          </div>
                        </div>
                        <div>
                          <label for="contact-info" class="block text-base font-medium leading-6 text-gray-900">Contact Info</label>
                          <div class="mt-2">
                            <div class="flex flex-wrap gap-0">
                              <p class="w-1/2 text-sm font-medium">Primary</p>
                              <p class="w-1/2 text-sm font-medium">Secondary</p>
                              <div class="w-1/2 text-sm font-normal text-gray-600">
                                <%!-- <p><%= @selected_contract_award.primary_contact_title %></p>
                                <p><%= @selected_contract_award.primary_contact_fullname %></p>
                                <p><%= @selected_contract_award.primary_contact_email %></p>
                                <p><%= @selected_contract_award.primary_contact_phone %></p>
                                <p><%= @selected_contract_award.primary_contact_fax %></p> --%>
                              </div>
                              <div class="w-1/2 text-sm font-normal text-gray-600">
                                <%!-- <p><%= @selected_contract_award.secondary_contact_title %></p>
                                <p><%= @selected_contract_award.secondary_contact_fullname %></p>
                                <p><%= @selected_contract_award.secondary_contact_email %></p>
                                <p><%= @selected_contract_award.secondary_contact_phone %></p>
                                <p><%= @selected_contract_award.secondary_contact_fax %></p> --%>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="pb-6 pt-4">
                        <div class="flex text-sm">
                          <a href={@selected_contract_award.usaspending_permalink} class="group inline-flex items-center font-medium text-brand hover:text-hovergreen">
                            <svg class="h-5 w-5 text-brand group-hover:text-hovergreen" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                              <path d="M12.232 4.232a2.5 2.5 0 013.536 3.536l-1.225 1.224a.75.75 0 001.061 1.06l1.224-1.224a4 4 0 00-5.656-5.656l-3 3a4 4 0 00.225 5.865.75.75 0 00.977-1.138 2.5 2.5 0 01-.142-3.667l3-3z" />
                              <path d="M11.603 7.963a.75.75 0 00-.977 1.138 2.5 2.5 0 01.142 3.667l-3 3a2.5 2.5 0 01-3.536-3.536l1.225-1.224a.75.75 0 00-1.061-1.06l-1.224 1.224a4 4 0 105.656 5.656l3-3a4 4 0 00-.225-5.865z" />
                            </svg>
                            <span class="ml-2">Copy link</span>
                          </a>
                        </div>
                        <div class="mt-4 flex text-sm">
                          <a href="#" class="group inline-flex items-center text-gray-500 hover:text-gray-900">
                            <svg class="h-5 w-5 text-gray-400 group-hover:text-gray-500" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zM8.94 6.94a.75.75 0 11-1.061-1.061 3 3 0 112.871 5.026v.345a.75.75 0 01-1.5 0v-.5c0-.72.57-1.172 1.081-1.287A1.5 1.5 0 108.94 6.94zM10 15a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd" />
                            </svg>
                            <span class="ml-2">Learn more about sharing</span>
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="flex flex-shrink-0 justify-end px-4 py-4">
                  <button type="button" class="rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">Cancel</button>
                  <button phx-click="add_to_pursuits" phx-value-id={@selected_contract_award.award_id_piid} class="ml-4 inline-flex justify-center rounded-md bg-brand px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-hovergreen focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand">Add to Pursuits</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
