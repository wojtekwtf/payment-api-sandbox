defmodule TransactionLinks do
  @derive Jason.Encoder
  defstruct [:self, :account]

  @type t :: %TransactionLinks{
          self: String.t(),
          account: String.t()
        }

  @spec get_transaction_links(TellerSandbox.Transaction.t()) :: TransactionLinks.t()
  def get_transaction_links(transaction) do
    %TransactionLinks{
      self:
        TellerSandboxWeb.Endpoint.url() <>
          "/accounts/" <> transaction.account_id <> "/transactions/" <> transaction.id,
      account: TellerSandboxWeb.Endpoint.url() <> "/accounts/" <> transaction.account_id
    }
  end
end

defmodule TellerSandbox.Transaction do
  @derive {Jason.Encoder,
           only: [:type, :running_balance, :links, :id, :description, :date, :amount, :account_id]}

  defstruct [:type, :running_balance, :links, :id, :description, :date, :amount, :account_id]

  @type t :: %TellerSandbox.Transaction{
          type: String.t(),
          running_balance: number(),
          links: TransactionLinks.t() | nil,
          id: String.t(),
          description: String.t(),
          date: Date.t(),
          amount: number(),
          account_id: String.t()
        }

  @spec set_links(TellerSandbox.Transaction.t()) :: TellerSandbox.Transaction.t()
  def set_links(transaction) do
    %{transaction | links: TransactionLinks.get_transaction_links(transaction)}
  end

  @spec generate_transactions(TellerSandbox.Account.t()) :: [TellerSandbox.Transaction.t()]
  def generate_transactions(account) do
    if account == nil do
      []
    else
      days_since_start = Date.diff(Date.utc_today(), account.start_date)

      1..days_since_start
      |> Enum.map(fn day -> create_transaction(day, account) end)
      |> Enum.map(fn transaction -> set_links(transaction) end)
    end
  end

  @spec create_transaction(number(), TellerSandbox.Account.t()) :: TellerSandbox.Transaction.t()
  def create_transaction(day, account) do
    amount = get_transaction_amount(day, account)
    date = get_transaction_date(day, account)
    running_balance = Balance.get_account_balance(account, date).available
    txn_id = "test_txn_" <> get_txn_id()

    %TellerSandbox.Transaction{
      type: "card_payment",
      running_balance: running_balance,
      id: txn_id,
      description: "test",
      date: date,
      amount: amount,
      account_id: account.id
    }

    # |> TellerSandbox.Transaction.set_links()
  end

  @spec get_transaction_amount(number(), TellerSandbox.Account.t()) :: number()
  defp get_transaction_amount(day, account) do
    cond do
      rem(day, 7) == 0 ->
        account.inflow

      true ->
        -account.outflow
    end
  end

  @spec get_transaction_date(number(), TellerSandbox.Account.t()) :: Date.t()
  defp get_transaction_date(day, account) do
    Date.add(account.start_date, day)
  end

  @spec get_txn_id :: String.t()
  defp get_txn_id do
    # Shameless copy paste from StackOverflow: https://stackoverflow.com/questions/32001606/how-to-generate-a-random-url-safe-string-with-elixir
    # No uniqness quaranteed
    :crypto.strong_rand_bytes(8) |> Base.url_encode64() |> binary_part(0, 8)
  end
end
