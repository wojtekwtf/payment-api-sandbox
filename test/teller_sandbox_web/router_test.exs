defmodule TellerSandboxWeb.RouterTest do
  use TellerSandboxWeb.ConnCase

  test "get accounts without the token", %{conn: conn} do
    conn = get(conn, Routes.account_path(conn, :index))

    response_data = json_response(conn, 401)

    assert response_data["errors"]["detail"] == TellerSandbox.Token.missing_token_error_message()
  end

  test "get single account without the token", %{conn: conn} do
    conn = get(conn, Routes.account_path(conn, :show, "test_acc_J1nzh90Z"))

    response_data = json_response(conn, 401)

    assert response_data["errors"]["detail"] == TellerSandbox.Token.missing_token_error_message()
  end

  test "get account transactions without the token", %{conn: conn} do
    conn = get(conn, Routes.transaction_path(conn, :index, "test_acc_J1nzh90Z"))

    response_data = json_response(conn, 401)

    assert response_data["errors"]["detail"] == TellerSandbox.Token.missing_token_error_message()
  end
end
