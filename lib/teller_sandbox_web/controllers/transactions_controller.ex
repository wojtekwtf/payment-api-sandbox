defmodule TellerSandboxWeb.TransactionController do
  use TellerSandboxWeb, :controller

  def index(conn, %{"account_id" => account_id}) do
    transactions = TellerSandbox.Repo.get_account_transactions(account_id)
    render(conn, %{transactions: transactions})
  end

  def show(conn, %{"account_id" => account_id, "id" => _}) do
    # Listing all the transaction, as we currently don't have a way of
    # retrieving just one transaction
    transactions = TellerSandbox.Repo.get_account_transactions(account_id)
    render(conn, "index.json", %{transactions: transactions})
  end
end
