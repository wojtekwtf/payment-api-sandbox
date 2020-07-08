defmodule TellerSandboxWeb.AccountControllerTest do
  use TellerSandboxWeb.ConnCase

  setup %{conn: conn} do
    conn = put_req_header(conn, "content-type", "application/json")
    conn = put_req_header(conn, "authorization", "test_AgBfBU-Ph-NciDT2Hekssaf")

    {:ok, %{conn: conn}}
  end

  test "get accounts", %{conn: conn} do
    conn = get(conn, Routes.account_path(conn, :index))

    response_data = json_response(conn, 200)

    assert length(response_data) == 5
    Enum.map(response_data, fn object -> validate_account_fields(object) end)
  end

  test "get single account", %{conn: conn} do
        conn = get(conn, Routes.account_path(conn, :show, "test_acc_G8mwe67W"))

    response_data = json_response(conn, 200)

    validate_account_fields(response_data)
  end

  def validate_account_fields(object) do

    # TODO validate with regex
    assert String.length(object["account_number"]) == 10
    # assert object["balances"]["available"] > 0
    # assert object["balances"]["ledger"] > 0
    assert String.length(object["currency_code"]) == 3
    assert String.starts_with?(object["enrollment_id"], "test_enr_")
    assert String.length(object["enrollment_id"]) == 17
    assert String.starts_with?(object["id"], "test_acc_")
    assert String.length(object["id"]) == 17
    assert String.length(object["institution"]["id"]) > 0
    assert String.length(object["institution"]["name"]) > 0
    assert String.length(object["name"]) > 0
    assert String.length(object["routing_numbers"]["ach"]) == 9
    assert String.length(object["routing_numbers"]["wire"]) == 10
    refute Map.has_key?(object, :inflow)
    refute Map.has_key?(object, :outflow)
  end
end
