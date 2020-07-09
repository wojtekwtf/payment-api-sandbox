defmodule PaymentSandboxWeb.TokenController do
  use PaymentSandboxWeb, :controller

  def index(conn, _params) do
    token = PaymentSandbox.Token.generate_api_token()
    render(conn, "index.json", %{token: token})
  end
end
