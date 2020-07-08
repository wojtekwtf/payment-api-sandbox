defmodule TellerSandbox.Token do

  @derive Jason.Encoder
  defstruct token: ""

  def generate_api_token do
    %TellerSandbox.Token{
      token: "test_" <> generate_random_string(23),
    }
  end

  defp generate_random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end
end
