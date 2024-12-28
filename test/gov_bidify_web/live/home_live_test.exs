defmodule GovBidifyWeb.HomeLiveTest do
  use GovBidifyWeb.ConnCase

  import GovBidify.Factory
  import Phoenix.LiveViewTest
  alias GovBidify.Opportunities.Opportunity

  test "home page loads", %{conn: conn} do
    assert {:ok, _view, _html} = live(conn, ~p"/")
  end

  test "search form updates results based on URL params", %{conn: conn} do
    insert(:opportunity, title: "Test Opportunity 1", description: "Some description", type: "Sources Sought")
    insert(:opportunity, title: "Test Opportunity 2", description: "Another description", type: "Request for Proposals")

    assert GovBidify.Repo.aggregate(Opportunity, :count) == 2

    {:ok, view, _html} = live(conn, ~p"/?query=Test+Opportunity&order_by[]=response_deadline&order_directions[]=asc&page_size=10&type[]=Sources+Sought")
    assert render(view) =~ "Test Opportunity 1"
    refute render(view) =~ "Test Opportunity 2"

    {:ok, view, _html} = live(conn, ~p"/?query=Another&order_by[]=response_deadline&order_directions[]=asc&page_size=10")
    assert render(view) =~ "Test Opportunity 2"
    refute render(view) =~ "Test Opportunity 1"
  end

  test "pagination works", %{conn: conn} do
    insert_list(5, :opportunity, title: "Test Opportunity A")
    insert_list(15, :opportunity, title: "Test Opportunity B")

    assert GovBidify.Repo.aggregate(Opportunity, :count) == 20

    {:ok, view, _html} = live(conn, ~p"/?query=Test+Opportunity&order_by[]=title&order_directions[]=asc&page_size=10&page=1")
    assert render(view) =~ "Test Opportunity A"
    assert render(view) =~ "Test Opportunity B"

    {:ok, view, _html} = live(conn, ~p"/?query=Test+Opportunity&order_by[]=title&order_directions[]=asc&page_size=10&page=2")
    refute render(view) =~ "Test Opportunity A"
    assert render(view) =~ "Test Opportunity B"

    {:ok, view, _html} = live(conn, ~p"/?query=Test+Opportunity&order_by[]=title&order_directions[]=asc&page_size=10&page=3")
    refute render(view) =~ "Test Opportunity A"
    refute render(view) =~ "Test Opportunity B"
  end
end
