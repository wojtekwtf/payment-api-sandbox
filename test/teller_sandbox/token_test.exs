defmodule PaymentSandbox.TokenTest do
  use ExUnit.Case

  test "generate a token" do
    token = PaymentSandbox.Token.generate_api_token()
    assert String.match?(token.token, ~r/^test_.{23}$/)
  end
end
