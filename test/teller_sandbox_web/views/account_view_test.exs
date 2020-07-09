defmodule PaymentSandboxWeb.AccountViewTest do
  use PaymentSandboxWeb.ConnCase
  alias PaymentSandboxWeb.AccountView

  test "get accounts" do
    account_1 = PaymentSandboxWeb.Factory.account_factory()
    account_2 = PaymentSandboxWeb.Factory.account_factory()
    account_3 = PaymentSandboxWeb.Factory.account_factory()

    accounts = [account_1, account_2, account_3]

    rendered_accounts = AccountView.render("index.json", %{accounts: accounts})

    assert rendered_accounts == accounts
  end

  test "get account detail" do
    account = PaymentSandboxWeb.Factory.account_factory()

    rendered_account = AccountView.render("account.json", %{account: account})

    assert rendered_account == account
  end
end
