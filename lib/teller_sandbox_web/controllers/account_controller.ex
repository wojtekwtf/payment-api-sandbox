defmodule PaymentSandboxWeb.AccountController do
  use PaymentSandboxWeb, :controller

  def index(conn, _params) do
    accounts = PaymentSandbox.Repo.get_all_accounts()
    render(conn, "index.json", %{accounts: accounts})
  end

  def show(conn, %{"id" => account_id}) do
    account = PaymentSandbox.Repo.get_account_by_id(account_id)

    if account == nil do
      conn
      |> put_status(:not_found)
      |> put_view(PaymentSandboxWeb.ErrorView)
      |> render(:"404")
    else
      render(conn, "account.json", %{account: account})
    end
  end
end
