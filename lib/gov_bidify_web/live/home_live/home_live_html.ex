defmodule GovBidifyWeb.HomeLiveHTML do
  use GovBidifyWeb, :html

  embed_templates "home_live/*"

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

  def datetime_handler(datetime, date_string \\ "", time_string \\ ""), do: datetime_conversion(datetime, date_string, time_string)

  defp datetime_conversion(nil, _date_string, _time_string), do: ""

  defp datetime_conversion(datetime, date_string, time_string) do
    period = if datetime.hour < 12, do: "AM", else: "PM"
    {:ok, edt_datetime} = DateTime.shift_zone(datetime, "America/New_York")
    time = time_conversion(edt_datetime, period)

    "#{date_string}#{edt_datetime.month}-#{edt_datetime.day}-#{edt_datetime.year}#{time_string}#{time}"
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
