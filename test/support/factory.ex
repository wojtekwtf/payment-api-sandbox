defmodule TellerSandboxWeb.Factory do
  def account_factory do
    %{
      account_number: "123",
      currency_code: "USD",
      name: "Test Chcecking Account",
      id: "test_acc_1"
    }
  end

  def transaction_factory do
    %{
      amount: "123",
      date: "2020-01-01",
      id: "test_txn_1",
      account_id: "test_acc_1"
    }
  end
end
