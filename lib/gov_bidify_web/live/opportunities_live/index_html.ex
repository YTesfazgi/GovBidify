defmodule GovBidifyWeb.OpportunitiesLive.IndexHTML do
  use GovBidifyWeb, :html

  embed_templates "index/*"

  def remove_replacement_symbol(string) do
    String.replace(string, "� ", " ")
    String.replace(string, ",�", ", ")
    String.replace(string, "�", " ")
  end

  def active_status(string) do
    case string do
      "Yes" ->
        "Active"

      "No" ->
        "Inactive"

      _ ->
        ""
    end
  end

  def mobile_search_bar(assigns) do
    ~H"""
    <div class="flex flex-1 gap-x-4 self-stretch lg:gap-x-6">
      <.form :let={f} for={@form} phx-submit="search" class="relative flex flex-1">
        <label for="mobile-search-field" class="sr-only">Search</label>
        <svg class="pointer-events-none absolute inset-y-0 left-3 h-full w-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
          <path fill-rule="evenodd" d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z" clip-rule="evenodd" />
        </svg>
        <.input id="mobile-search-field" type="mobile-search-bar" placeholder="Search..." field={f[:query]} />
      </.form>
    </div>
    """
  end

  def pop_handler(city, state, zip, country) do
    [city, state, zip, country]
    |> Enum.filter(&(&1 != ""))
    |> Enum.join(", ")
  end

  def date_formatter(date) when is_nil(date), do: ""

  def date_formatter(date) do
    "#{date.month}/#{date.day}/#{date.year}"
  end

  def datetime_handler(datetime, date_string \\ "", time_string \\ ""), do: datetime_conversion(datetime, date_string, time_string)

  defp datetime_conversion(nil, _date_string, _time_string), do: ""

  defp datetime_conversion(datetime, date_string, time_string) do
    period = if datetime.hour < 12, do: "AM", else: "PM"
    {:ok, edt_datetime} = DateTime.shift_zone(datetime, "America/New_York")
    time = time_conversion(edt_datetime, period)

    "#{date_string}#{edt_datetime.month}/#{edt_datetime.day}/#{edt_datetime.year}#{time_string}#{time}"
  end

  defp time_conversion(edt_datetime, period) do
    hour =
      case edt_datetime.hour do
        0 -> 12
        h when h > 12 -> h - 12
        h -> h
      end

    minute_str = Integer.to_string(edt_datetime.minute)
    |> String.pad_leading(2, "0")

    "#{hour}:#{minute_str} #{period} #{edt_datetime.zone_abbr}"
  end
end
