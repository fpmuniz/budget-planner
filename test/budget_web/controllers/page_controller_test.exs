defmodule BudgetWeb.PageControllerTest do
  use BudgetWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Budget!"
  end
end
