defmodule SamClientTest do
  use GovBidifyWeb.ConnCase

  test "hit test API url" do
    params = %{"postedFrom" => "01/01/2018", "postedTo" => "05/10/2018", "ptype" => "a", "deptname" => "general"}

    assert {:ok, _body} = SamClient.search(params)
  end
end
