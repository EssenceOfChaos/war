defmodule WarWeb.PageControllerTest do
  use WarWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Let's Play War!"
  end
end
