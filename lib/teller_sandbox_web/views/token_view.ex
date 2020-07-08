defmodule TellerSandboxWeb.TokenView do
  use TellerSandboxWeb, :view

  def render("index.json", %{token: token}) do
    token
  end
end
