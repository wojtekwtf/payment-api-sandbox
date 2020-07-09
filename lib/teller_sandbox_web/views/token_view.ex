defmodule PaymentSandboxWeb.TokenView do
  use PaymentSandboxWeb, :view

  def render("index.json", %{token: token}) do
    token
  end
end
