defmodule TellerSandboxWeb.AccountController do
  use TellerSandboxWeb, :controller

  def index(conn, _params) do
    accounts = TellerSandbox.Repo.get_all_accounts()
    render(conn, "index.json", %{accounts: accounts})
  end

  def show(conn, %{"id" => account_id}) do
    account = TellerSandbox.Repo.get_account_by_id(account_id)

    if account == nil do
      conn
      |> put_status(:not_found)
      |> put_view(TellerSandboxWeb.ErrorView)
      |> render(:"404")
    else
      render(conn, "account.json", %{account: account})
    end
  end
end
