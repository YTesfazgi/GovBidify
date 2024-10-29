defmodule GovBidifyWeb.HomeLiveTest do
  use GovBidifyWeb.ConnCase

  import GovBidify.Factory
  import Phoenix.LiveViewTest
  alias GovBidify.Opportunities.Opportunity

  test "home page loads", %{conn: conn} do
    {:ok, _view, _html} = live(conn, ~p"/")
  end

  test "search form updates results based on URL params", %{conn: conn} do
    insert(:opportunity, title: "Test Opportunity 1", description: "Some description", type: "Sources Sought")
    insert(:opportunity, title: "Test Opportunity 2", description: "Another description", type: "Request for Proposals")

    assert GovBidify.Repo.aggregate(Opportunity, :count) == 2

    {:ok, view, _html} = live(conn, ~p"/?query=Test+Opportunity&flop%5Border_by%5D%5B%5D=response_deadline&flop%5Border_directions%5D%5B%5D=asc&flop%5Bpage_size%5D=10&flop%5Bfilters%5D=%7B%22city%22%3A%5B%5D%2C%22country%22%3A%5B%5D%2C%22department%22%3A%5B%5D%2C%22office%22%3A%5B%5D%2C%22state%22%3A%5B%5D%2C%22sub_tier%22%3A%5B%5D%2C%22type%22%3A%5B%22Sources+Sought%22%5D%7D")
    assert render(view) =~ "Test Opportunity 1"
    refute render(view) =~ "Test Opportunity 2"

    {:ok, view, _html} = live(conn, ~p"/?query=Another&flop%5Border_by%5D%5B%5D=response_deadline&flop%5Border_directions%5D%5B%5D=asc&flop%5Bpage_size%5D=10&flop%5Bfilters%5D=%7B%22city%22%3A%5B%5D%2C%22country%22%3A%5B%5D%2C%22department%22%3A%5B%5D%2C%22office%22%3A%5B%5D%2C%22state%22%3A%5B%5D%2C%22sub_tier%22%3A%5B%5D%2C%22type%22%3A%5B%22Request+for+Proposals%22%5D%7D")
    assert render(view) =~ "Test Opportunity 2"
    refute render(view) =~ "Test Opportunity 1"
  end

  test "pagination works", %{conn: conn} do
    insert_list(1, :opportunity, title: "Apples")
    insert_list(19, :opportunity, title: "Bananas")

    assert GovBidify.Repo.aggregate(Opportunity, :count) == 20

    {:ok, view, _html} = live(conn, ~p"/?order_by[]=response_deadline&order_directions[]=asc&page_size=10&page=4&query=Apples")
    assert render(view) =~ "Apples"
    refute render(view) =~ "Bananas"
  end
end
