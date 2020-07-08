defmodule TellerSandbox.Token do
  @derive Jason.Encoder
  defstruct [:token]

  @type t :: %TellerSandbox.Token{
          token: String.t()
        }

  @spec generate_api_token :: TellerSandbox.Token.t()
  def generate_api_token do
    %TellerSandbox.Token{
      token: "test_" <> generate_random_string(23)
    }
  end

  defp generate_random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end
end
