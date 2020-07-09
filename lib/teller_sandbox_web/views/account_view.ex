defmodule TellerSandboxWeb.AccountView do
  use TellerSandboxWeb, :view

  def render("index.json", %{accounts: accounts}) do
    render_many(accounts, TellerSandboxWeb.AccountView, "account.json")
  end

  def render("account.json", %{account: account}) do
    account
  end
end
