defmodule TellerSandboxWeb.TransactionController do
  use TellerSandboxWeb, :controller

  def index(conn, %{"account_id" => _account_id}) do
    render conn, %{transactions: ["transaction_1", "transaction_2"]}
  end
end
