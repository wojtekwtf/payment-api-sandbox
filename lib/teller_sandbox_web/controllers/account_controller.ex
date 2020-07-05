defmodule TellerSandboxWeb.AccountController do
  use TellerSandboxWeb, :controller

  def index(conn, _params) do
    render conn, "index.json", %{accounts: []}
  end

  def show(conn, %{"id" => id}) do
    render conn, "account.json", %{account: id}
  end
end
