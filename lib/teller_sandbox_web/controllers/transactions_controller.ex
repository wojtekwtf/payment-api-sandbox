defmodule TellerSandboxWeb.TransactionController do
  use TellerSandboxWeb, :controller

  def index(conn, %{"account_id" => account_id}) do
    account = TellerSandbox.Repo.get_account_by_id(account_id)

    if account == nil do
      conn
      |> put_status(:not_found)
      |> put_view(TellerSandboxWeb.ErrorView)
      |> render(:"404")
    else
      transactions = TellerSandbox.Repo.get_account_transactions(account)
      render(conn, %{transactions: transactions})
    end
  end

  def show(conn, %{"account_id" => account_id, "id" => _}) do
    # Listing all the transaction, as we currently don't have a way of
    # retrieving just one transaction
    account = TellerSandbox.Repo.get_account_by_id(account_id)

    if account == nil do
      conn
      |> put_status(:not_found)
      |> put_view(TellerSandboxWeb.ErrorView)
      |> render(:"404")
    else
      transactions = TellerSandbox.Repo.get_account_transactions(account)
      render(conn, "index.json", %{transactions: transactions})
    end
  end
end
