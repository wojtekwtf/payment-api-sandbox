defmodule TellerSandboxWeb.TokenController do
  use TellerSandboxWeb, :controller

  def index(conn, _params) do
    token = TellerSandbox.Token.generate_api_token()
    render(conn, "index.json", %{token: token})
  end
end
