defmodule GovBidifyWeb.HomeLiveHTML do
  use GovBidifyWeb, :html

  embed_templates "home_live/*"

  def remove_replacement_symbol(string) do
    String.replace(string, "� ", " ")
    String.replace(string, "�", " ")
    # unless it is preceded by a comma (,)
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
    date = DateTime.to_date(datetime)
    time = DateTime.to_time(datetime)
    "#{date_string}#{date.month}-#{date.day}-#{date.year}#{time_string}#{time}"
  end
end
