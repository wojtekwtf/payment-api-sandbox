defmodule TellerSandboxWeb.TokenViewTest do
  use TellerSandboxWeb.ConnCase
  alias TellerSandboxWeb.TokenView

  test "get token" do
    token = TellerSandbox.Token.generate_api_token()
    rendered_token = TokenView.render("index.json", %{token: token})

    assert rendered_token == token
  end
end
