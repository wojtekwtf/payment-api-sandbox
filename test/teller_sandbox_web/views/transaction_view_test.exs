defmodule TellerSandboxWeb.TransactionViewTest do
  use TellerSandboxWeb.ConnCase

  alias TellerSandboxWeb.TransactionView

  test "get transactions" do
    transaction_1 = TellerSandboxWeb.Factory.transaction_factory()
    transaction_2 = TellerSandboxWeb.Factory.transaction_factory()
    transaction_3 = TellerSandboxWeb.Factory.transaction_factory()

    transactions = [transaction_1, transaction_2, transaction_3]

    rendered_transactions = TransactionView.render("index.json", %{transactions: transactions})

    assert rendered_transactions == transactions
  end

end
