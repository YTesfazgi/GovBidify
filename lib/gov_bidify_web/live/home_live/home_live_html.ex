defmodule GovBidifyWeb.HomeLiveHTML do
  use GovBidifyWeb, :html

  embed_templates "home_live/*"

  def remove_replacement_symbol(string) do
    String.replace(string, "� ", " ")
    String.replace(string, "�", " ")
    # unless it is preceded by a comma (,)
  end
end
