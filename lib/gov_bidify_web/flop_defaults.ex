defmodule GovBidifyWeb.FlopDefaults do
  def opportunity_flop do
    %{
      "page_size" => 10,
      "order_by" => ["response_deadline"],
      "order_directions" => ["asc"]
    }
  end

  def contract_award_flop do
    %{
      "page_size" => 10,
      "order_by" => ["action_date"],
      "order_directions" => ["desc"]
    }
  end

  def opportunity_meta do
    %Flop.Meta{
      flop: opportunity_flop(),
      has_next_page?: false,
      has_previous_page?: false,
      next_page: nil,
      previous_page: nil
    }
  end

  def contract_award_meta do
    %Flop.Meta{
      flop: contract_award_flop(),
      has_next_page?: false,
      has_previous_page?: false,
      next_page: nil,
      previous_page: nil
    }
  end
end
