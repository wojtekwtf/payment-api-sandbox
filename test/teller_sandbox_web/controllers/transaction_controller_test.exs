defmodule PaymentSandboxWeb.TransactionControllerTest do
  use PaymentSandboxWeb.ConnCase

  setup %{conn: conn} do
    conn = put_req_header(conn, "authorization", "test_AgBfBU-Ph-NciDT2Hekssaf")

    {:ok, %{conn: conn}}
  end

  test "get account transactions", %{conn: conn} do
    account_id = "test_acc_J1nzh90Z"
    account = PaymentSandbox.Repo.get_account_by_id(account_id)
    conn = get(conn, Routes.transaction_path(conn, :index, account_id))

    response_data = json_response(conn, 200)

    days_since_start = Date.diff(Date.utc_today(), account.start_date)

    assert length(response_data) == days_since_start
    Enum.map(response_data, fn object -> validate_transaction_fields(object) end)
  end

  test "get account transactions fake detail", %{conn: conn} do
    # this test just checks if the "detail" transaction view behaves the same as list
    account_id = "test_acc_J1nzh90Z"
    account = PaymentSandbox.Repo.get_account_by_id(account_id)
    conn = get(conn, Routes.transaction_path(conn, :show, account_id, "doesnt_matter"))

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

  test "get account transactions fake detail bad id", %{conn: conn} do
    account_id = "doesn't exist"
    conn = get(conn, Routes.transaction_path(conn, :show, account_id, "doesnt_matter"))

    response_data = json_response(conn, 404)
    assert response_data["errors"]["detail"] == "Not Found"
  end

  def validate_transaction_fields(object) do
    assert String.length(object["type"]) > 0
    assert String.match?(object["id"], ~r/^test_txn_.{8}$/)
    assert String.match?(object["description"], ~r/.*/)
    refute object["amount"] == 0
    assert String.match?(object["account_id"], ~r/^test_acc_.{8}$/)

    assert object["links"]["self"] ==
             "http://localhost:4002/accounts/test_acc_J1nzh90Z/transactions/" <> object["id"]

    assert object["links"]["account"] == "http://localhost:4002/accounts/test_acc_J1nzh90Z"
  end
end
