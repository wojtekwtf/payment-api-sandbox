defmodule TellerSanbox.TransactionTest do
  use ExUnit.Case

  test "transactions value equal to account balance" do

    account = TellerSandboxWeb.Factory.account_factory_with_balance()
    transactions = TellerSandbox.Transaction.generate_transactions(account)

    transaction_sum = Enum.map(transactions, fn transaction -> transaction.amount end)
    |> Enum.sum()

    assert transaction_sum == account.balances.available
  end

  test "create single transaction" do
    account = TellerSandboxWeb.Factory.account_factory(500, 300, ~D[2020-07-01])
    transaction = TellerSandbox.Transaction.create_transaction(1, account)

    assert transaction.type == "card_payment" # TODO no other type supported yet
    assert transaction.running_balance == -300
    assert String.starts_with?(transaction.id, "test_txn_")
    assert String.length(transaction.id) == 17
    assert transaction.description == "test" # TODO no other description supported yet
    assert transaction.date == ~D[2020-07-02]
    assert transaction.amount == -300
    assert transaction.account_id == account.id
  end
end