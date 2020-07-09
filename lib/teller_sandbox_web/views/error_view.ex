defmodule PaymentSandboxWeb.ErrorView do
  use PaymentSandboxWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render("404.json", _assigns) do
    %{errors: %{detail: "Not Found"}}
  end

  def render("401.json", _assigns) do
    %{errors: %{detail: PaymentSandbox.Token.missing_token_error_message()}}
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
