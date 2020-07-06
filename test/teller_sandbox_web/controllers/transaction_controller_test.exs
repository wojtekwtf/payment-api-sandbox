defmodule TellerSandboxWeb.TransactionControllerTest do
  use TellerSandboxWeb.ConnCase

  test "get account transactions", %{conn: conn} do
    conn = get(conn, Routes.transaction_path(conn, :index, "test_acc_G8mwe67W"))
    response_data = json_response(conn, 200)

    {:ok, start} = Date.new(2020, 6, 1)
    days_since_start = Date.diff(Date.utc_today(), start)

    assert length(response_data) == days_since_start
    Enum.map(response_data, fn object -> validate_transaction_fields(object) end)
  end

  def validate_transaction_fields(object) do

    # TODO validate with regex
    assert String.length(object["type"]) > 0
    assert object["running_balance"] > 0
    assert String.starts_with?(object["id"], "test_txn_")
    assert String.length(object["id"]) == 17
    assert String.length(object["description"]) > 0
    refute object["amount"] == 0
    assert String.starts_with?(object["account_id"], "test_acc_")
    assert String.length(object["account_id"]) == 17

  end
end
