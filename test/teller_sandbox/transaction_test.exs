defmodule PaymentSanbox.TransactionTest do
  use ExUnit.Case

  test "transactions value equal to account balance" do
    account =
      PaymentSandboxWeb.Factory.account_factory()
      |> PaymentSandbox.Account.set_account_balance()

    transactions = PaymentSandbox.Transaction.generate_transactions(account)

    transaction_sum =
      Enum.map(transactions, fn transaction -> transaction.amount end)
      |> Enum.sum()

    assert transaction_sum == account.balances.available
  end

  test "create single transaction" do
    account = PaymentSandboxWeb.Factory.account_factory(500, 300, ~D[2020-07-01])
    transaction = PaymentSandbox.Transaction.create_transaction(1, account)

    assert transaction.type == "card_payment"
    assert transaction.running_balance == -300
    assert String.match?(transaction.id, ~r/^test_txn_.{8}$/)
    assert transaction.description == "test"
    assert transaction.date == ~D[2020-07-02]
    assert transaction.amount == -300
    assert transaction.account_id == account.id
  end

  test "get transaction links" do
    transaction = PaymentSandboxWeb.Factory.transaction_factory()
    links = TransactionLinks.get_transaction_links(transaction)

    assert links.self ==
             "http://localhost:4002/accounts/test_acc_11111111/transactions/test_txn_12345678"

    assert links.account == "http://localhost:4002/accounts/test_acc_11111111"
  end

  test "set transaction links" do
    transaction =
      PaymentSandboxWeb.Factory.transaction_factory()
      |> PaymentSandbox.Transaction.set_links()

    assert transaction.links.self ==
             "http://localhost:4002/accounts/test_acc_11111111/transactions/test_txn_12345678"

    assert transaction.links.account == "http://localhost:4002/accounts/test_acc_11111111"
  end
end
