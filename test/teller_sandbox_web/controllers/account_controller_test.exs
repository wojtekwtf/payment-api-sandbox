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
    assert String.match?(object["account_number"], ~r/^\d{10}$/)
    assert object["currency_code"] == "USD"
    assert String.match?(object["enrollment_id"], ~r/^test_enr_.{8}$/)
    assert String.match?(object["id"], ~r/^test_acc_.{8}$/)
    assert String.match?(object["institution"]["id"], ~r/.*/)
    assert String.match?(object["institution"]["name"], ~r/.*/)
    assert String.match?(object["name"], ~r/.*/)
    assert String.match?(object["routing_numbers"]["ach"], ~r/^\d{9}$/)
    assert String.match?(object["routing_numbers"]["wire"], ~r/^\d{10}$/)
    refute Map.has_key?(object, :inflow)
    refute Map.has_key?(object, :outflow)
  end
end
