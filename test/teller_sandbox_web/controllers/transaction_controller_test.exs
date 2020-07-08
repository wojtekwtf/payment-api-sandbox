defmodule TellerSandboxWeb.TransactionControllerTest do
  use TellerSandboxWeb.ConnCase

  setup %{conn: conn} do
    conn = put_req_header(conn, "content-type", "application/json")
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

  def validate_transaction_fields(object) do
    # TODO validate with regex
    assert String.length(object["type"]) > 0
    assert String.starts_with?(object["id"], "test_txn_")
    assert String.length(object["id"]) == 17
    assert String.length(object["description"]) > 0
    refute object["amount"] == 0
    assert String.starts_with?(object["account_id"], "test_acc_")
    assert String.length(object["account_id"]) == 17
  end
end
