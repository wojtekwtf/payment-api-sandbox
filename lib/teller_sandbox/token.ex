defmodule PaymentSandbox.Token do
  @derive Jason.Encoder
  defstruct [:token]

  @type t :: %PaymentSandbox.Token{
          token: String.t()
        }

  @spec missing_token_error_message :: String.t()
  def missing_token_error_message do
    token_url = PaymentSandboxWeb.Endpoint.url() <> "/token"

    "You need an authorization token to run this request. Get yours at " <>
      token_url <> " and put it in the authorization header"
  end

  @spec generate_api_token :: PaymentSandbox.Token.t()
  def generate_api_token do
    %PaymentSandbox.Token{
      token: "test_" <> generate_random_string(23)
    }
  end

  defp generate_random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end
end
