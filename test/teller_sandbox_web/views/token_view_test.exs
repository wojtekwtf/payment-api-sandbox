defmodule PaymentSandboxWeb.TokenViewTest do
  use PaymentSandboxWeb.ConnCase
  alias PaymentSandboxWeb.TokenView

  test "get token" do
    token = PaymentSandbox.Token.generate_api_token()
    rendered_token = TokenView.render("index.json", %{token: token})

    assert rendered_token == token
  end
end
