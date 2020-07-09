defmodule TellerSandboxWeb.TransactionControllerTest do
  use TellerSandboxWeb.ConnCase

  setup %{conn: conn} do
    conn = put_req_header(conn, "authorization", "test_AgBfBU-Ph-NciDT2Hekssaf")

    {:ok, %{conn: conn}}
  end

  test "get account transactions", %{conn: conn} do
    account_id = "test_acc_J1nzh90Z"
    account = TellerSandbox.Repo.get_account_by_id(account_id)
    conn = get(conn, Routes.transaction_path(conn, :index, account_id))

    response_data = json_response(conn, 200)

    days_since_start = Date.diff(Date.utc_today(), account.start_date)

    assert length(response_data) == days_since_start
    Enum.map(response_data, fn object -> validate_transaction_fields(object) end)
  end

  test "get account transactions bad id", %{conn: conn} do
    conn = get(conn, Routes.transaction_path(conn, :index, "I don't exist"))

    response_data = json_response(conn, 404)
    assert response_data["errors"]["detail"] == "Not Found"
  end

  def validate_transaction_fields(object) do
    assert String.length(object["type"]) > 0
    assert String.match?(object["id"], ~r/^test_txn_.{8}$/)
    assert String.match?(object["description"], ~r/.*/)
    refute object["amount"] == 0
    assert String.match?(object["account_id"], ~r/^test_acc_.{8}$/)
  end
end
