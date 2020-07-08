defmodule TellerSandboxWeb.TransactionController do
  use TellerSandboxWeb, :controller

  def index(conn, %{"account_id" => account_id}) do
    transactions = TellerSandbox.Repo.get_account_transactions(account_id)
    render(conn, %{transactions: transactions})
  end
end
