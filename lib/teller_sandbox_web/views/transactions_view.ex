defmodule TellerSandboxWeb.TransactionView do
  use TellerSandboxWeb, :view

  def render("index.json", %{transactions: transactions}) do
    render_many(transactions, TellerSandboxWeb.TransactionView, "transaction.json")
  end

  def render("transaction.json", %{transaction: transaction}) do
    transaction
  end
end
