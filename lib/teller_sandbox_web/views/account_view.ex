defmodule PaymentSandboxWeb.AccountView do
  use PaymentSandboxWeb, :view

  def render("index.json", %{accounts: accounts}) do
    render_many(accounts, PaymentSandboxWeb.AccountView, "account.json")
  end

  def render("account.json", %{account: account}) do
    account
  end
end
