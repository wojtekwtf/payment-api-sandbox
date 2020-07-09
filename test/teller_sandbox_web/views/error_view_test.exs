defmodule PaymentSandboxWeb.ErrorViewTest do
  use PaymentSandboxWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 401.json" do
    assert render(PaymentSandboxWeb.ErrorView, "401.json", []) == %{
             errors: %{detail: PaymentSandbox.Token.missing_token_error_message()}
           }
  end

  test "renders 404.json" do
    assert render(PaymentSandboxWeb.ErrorView, "404.json", []) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "renders 500.json" do
    assert render(PaymentSandboxWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
