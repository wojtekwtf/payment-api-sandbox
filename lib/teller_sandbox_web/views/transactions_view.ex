defmodule PaymentSandboxWeb.TransactionView do
  use PaymentSandboxWeb, :view

  def render("index.json", %{transactions: transactions}) do
    render_many(transactions, PaymentSandboxWeb.TransactionView, "transaction.json")
  end

  def render("transaction.json", %{transaction: transaction}) do
    transaction
  end
end
