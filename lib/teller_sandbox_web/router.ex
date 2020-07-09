defmodule PaymentSandboxWeb.Router do
  use PaymentSandboxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :validate_test_token_header
  end

  scope "/", PaymentSandboxWeb do
    pipe_through :api

    resources "/accounts", AccountController, only: [:index, :show]
    resources "/accounts/:account_id/transactions", TransactionController, only: [:index, :show]
  end

  scope "/", PaymentSandboxWeb do
    # doesn't check the token
    get "/token", TokenController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PaymentSandboxWeb.Telemetry
    end
  end

  defp validate_test_token_header(conn, _) do
    token = Plug.Conn.get_req_header(conn, "authorization")
    validate_token_characters(conn, token)
  end

  defp validate_token_characters(conn, []) do
    # Matches if there is no authorization header
    send_401_unauthorized_http_response(conn)
  end

  defp validate_token_characters(conn, [token]) do
    if !String.match?(token, ~r/^test_.{23}$/) do
      send_401_unauthorized_http_response(conn)
    else
      conn
    end
  end

  defp send_401_unauthorized_http_response(conn) do
    conn
    |> put_status(:unauthorized)
    |> put_view(PaymentSandboxWeb.ErrorView)
    |> render(:"401")
    |> halt
  end
end
