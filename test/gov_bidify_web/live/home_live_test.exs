defmodule GovBidifyWeb.OpportunitiesLiveTest do
  use GovBidifyWeb.ConnCase

  import GovBidify.Factory
  import Phoenix.LiveViewTest
  alias GovBidify.Opportunities.Opportunity

  test "opportunities page loads", %{conn: conn} do
    assert {:ok, _view, _html} = live(conn, ~p"/opportunities/")
  end

  test "search form updates results based on URL params", %{conn: conn} do
    insert(:opportunity, title: "Test Opportunity 1", description: "Some description", type: "Sources Sought")
    insert(:opportunity, title: "Test Opportunity 2", description: "Another description", type: "Request for Proposals")

    assert GovBidify.Repo.aggregate(Opportunity, :count) == 2

    {:ok, view, _html} = live(conn, ~p"/opportunities/?query=Test+Opportunity&order_by[]=response_deadline&order_directions[]=asc&page_size=10&type[]=Sources+Sought")
    assert render(view) =~ "Test Opportunity 1"
    refute render(view) =~ "Test Opportunity 2"

    {:ok, view, _html} = live(conn, ~p"/opportunities/?query=Another&order_by[]=response_deadline&order_directions[]=asc&page_size=10")
    assert render(view) =~ "Test Opportunity 2"
    refute render(view) =~ "Test Opportunity 1"
  end

  test "pagination works", %{conn: conn} do
    insert_list(5, :opportunity, title: "Test Opportunity A")
    insert_list(15, :opportunity, title: "Test Opportunity B")

    assert GovBidify.Repo.aggregate(Opportunity, :count) == 20

    {:ok, view, _html} = live(conn, ~p"/opportunities/?query=Test+Opportunity&order_by[]=title&order_directions[]=asc&page_size=10&page=1")
    assert render(view) =~ "Test Opportunity A"
    assert render(view) =~ "Test Opportunity B"

    {:ok, view, _html} = live(conn, ~p"/opportunities/?query=Test+Opportunity&order_by[]=title&order_directions[]=asc&page_size=10&page=2")
    refute render(view) =~ "Test Opportunity A"
    assert render(view) =~ "Test Opportunity B"

    {:ok, view, _html} = live(conn, ~p"/opportunities/?query=Test+Opportunity&order_by[]=title&order_directions[]=asc&page_size=10&page=3")
    refute render(view) =~ "Test Opportunity A"
    refute render(view) =~ "Test Opportunity B"
  end

  describe "filters" do
    test "filter modal can be opened and closed", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/opportunities/")

      refute render(view) =~ "modal-open"

      view
      |> element("button", "Filters")
      |> render_click()

      assert render(view) =~ "modal-open"

      view
      |> element("button[phx-click='close_filter_modal']")
      |> render_click()

      refute render(view) =~ "modal-open"
    end

    test "multiple filters can be applied together", %{conn: conn} do
      insert(:opportunity,
        title: "Defense Contract",
        type: "Sources Sought",
        department_ind_agency: "Department of Defense",
        set_aside: "Small Business"
      )
      insert(:opportunity,
        title: "Agriculture Contract",
        type: "Sources Sought",
        department_ind_agency: "Department of Agriculture",
        set_aside: "None"
      )

      {:ok, _view, _html} = live(conn, ~p"/opportunities/")

      # Apply multiple filters
      {:ok, view, _html} = live(conn, ~p"/opportunities/?type[]=Sources+Sought&department_ind_agency[]=Department+of+Defense&set_aside[]=Small+Business")

      assert render(view) =~ "Defense Contract"
      refute render(view) =~ "Agriculture Contract"
    end
  end

  describe "sorting" do
    test "results can be sorted by different fields", %{conn: conn} do
      insert(:opportunity, title: "A Contract", response_deadline: ~N[2024-03-01 00:00:00])
      insert(:opportunity, title: "B Contract", response_deadline: ~N[2024-02-01 00:00:00])

      # Test sorting by title ascending
      {:ok, view, _html} = live(conn, ~p"/opportunities/?query=Contract&order_by[]=title&order_directions[]=asc")
      html = render(view)
      assert html =~ ~r/A Contract.*B Contract/s

      # Test sorting by deadline descending
      {:ok, view, _html} = live(conn, ~p"/opportunities/?query=Contract&order_by[]=response_deadline&order_directions[]=desc")
      html = render(view)
      assert html =~ ~r/A Contract.*B Contract/s
    end
  end

  describe "search functionality" do
    test "search is case insensitive", %{conn: conn} do
      insert(:opportunity, title: "TEST Opportunity")

      {:ok, view, _html} = live(conn, ~p"/opportunities/?query=test")
      assert render(view) =~ "TEST Opportunity"
    end

    test "search works with partial matches", %{conn: conn} do
      insert(:opportunity, title: "Complex Project Opportunity")

      {:ok, view, _html} = live(conn, ~p"/opportunities/?query=complex")
      assert render(view) =~ "Complex Project Opportunity"
    end

    test "search returns empty results for non-matching query", %{conn: conn} do
      insert(:opportunity, title: "Test Opportunity")

      {:ok, view, _html} = live(conn, ~p"/opportunities/?query=nonexistent")
      refute render(view) =~ "Test Opportunity"
    end
  end
end
