defmodule GovBidifyWeb.FlopDefaults do
  def default_flop do
    %{
      "page_size" => 10,
      "order_by" => ["response_deadline"],
      "order_directions" => ["asc"]
    }
  end

  def default_meta do
    %Flop.Meta{
      flop: default_flop(),
      has_next_page?: false,
      has_previous_page?: false,
      next_page: nil,
      previous_page: nil
    }
  end
end
