defmodule TellerSanbox.TransactionTest do
  use ExUnit.Case

  test "transactions value equal to account balance" do

    account = TellerSandboxWeb.Factory.account_factory()
    transactions = TellerSandbox.Transaction.generate_transactions(account)

    transaction_sum = Enum.map(transactions, fn transaction -> transaction.amount end)
    |> Enum.sum()

    assert transaction_sum == account.balances.available
  end
end
