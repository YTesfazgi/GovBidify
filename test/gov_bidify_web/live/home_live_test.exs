defmodule GovBidifyWeb.HomeLiveTest do
  use GovBidifyWeb.ConnCase

  import Phoenix.LiveViewTest

  test "home page loads", %{conn: conn} do
    {:ok, _view, _html} = live(conn, ~p"/")
  end
end
