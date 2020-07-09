defmodule PaymentSandboxWeb.TransactionViewTest do
  use PaymentSandboxWeb.ConnCase

  alias PaymentSandboxWeb.TransactionView

  test "get transactions" do
    transaction_1 = PaymentSandboxWeb.Factory.transaction_factory()
    transaction_2 = PaymentSandboxWeb.Factory.transaction_factory()
    transaction_3 = PaymentSandboxWeb.Factory.transaction_factory()

    transactions = [transaction_1, transaction_2, transaction_3]

    rendered_transactions = TransactionView.render("index.json", %{transactions: transactions})

    assert rendered_transactions == transactions
  end
end
