defmodule PaymentSandboxWeb.TokenControllerTest do
  use PaymentSandboxWeb.ConnCase

  test "get token", %{conn: conn} do
    conn = get(conn, Routes.token_path(conn, :index))

    response_data = json_response(conn, 200)

    assert String.match?(response_data["token"], ~r/^test_.{23}$/)
  end
end
