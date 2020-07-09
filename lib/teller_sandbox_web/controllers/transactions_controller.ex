defmodule PaymentSandboxWeb.TransactionController do
  use PaymentSandboxWeb, :controller

  def index(conn, %{"account_id" => account_id}) do
    account = PaymentSandbox.Repo.get_account_by_id(account_id)

    if account == nil do
      conn
      |> put_status(:not_found)
      |> put_view(PaymentSandboxWeb.ErrorView)
      |> render(:"404")
    else
      transactions = PaymentSandbox.Repo.get_account_transactions(account)
      render(conn, %{transactions: transactions})
    end
  end

  def show(conn, %{"account_id" => account_id, "id" => _}) do
    # Listing all the transaction, as we currently don't have a way of
    # retrieving just one transaction
    account = PaymentSandbox.Repo.get_account_by_id(account_id)

    if account == nil do
      conn
      |> put_status(:not_found)
      |> put_view(PaymentSandboxWeb.ErrorView)
      |> render(:"404")
    else
      transactions = PaymentSandbox.Repo.get_account_transactions(account)
      render(conn, "index.json", %{transactions: transactions})
    end
  end
end
