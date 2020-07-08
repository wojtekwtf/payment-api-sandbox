defmodule TellerSandboxWeb.AccountController do
  use TellerSandboxWeb, :controller

  def index(conn, _params) do
    accounts = TellerSandbox.Repo.get_all_accounts()
    render(conn, "index.json", %{accounts: accounts})
  end

  def show(conn, %{"id" => id}) do
    account = TellerSandbox.Repo.get_account_by_id(id)
    render(conn, "account.json", %{account: account})
  end
end
