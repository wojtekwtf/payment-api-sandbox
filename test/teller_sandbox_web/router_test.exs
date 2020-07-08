defmodule TellerSandboxWeb.RouterTest do
  use TellerSandboxWeb.ConnCase

  test "get accounts without the token", %{conn: conn} do
    conn = get(conn, Routes.account_path(conn, :index))

    response_data = json_response(conn, 403)

    assert response_data["error_message"] == "You need an authorization token to run this request"
  end

  test "get single account without the token", %{conn: conn} do
    conn = get(conn, Routes.account_path(conn, :show, "test_acc_J1nzh90Z"))

    response_data = json_response(conn, 403)

    assert response_data["error_message"] == "You need an authorization token to run this request"
  end

  test "get account transactions without the token", %{conn: conn} do
    conn = get(conn, Routes.transaction_path(conn, :index, "test_acc_J1nzh90Z"))

    response_data = json_response(conn, 403)

    assert response_data["error_message"] == "You need an authorization token to run this request"
  end
end
