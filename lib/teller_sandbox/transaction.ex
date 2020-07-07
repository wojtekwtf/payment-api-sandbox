defmodule TellerSandbox.Transaction do
  @derive {Jason.Encoder, only: [:type,
                                 :running_balance,
                                 :id,
                                 :description,
                                 :date,
                                 :amount,
                                 :account_id]}
  defstruct type: "",
           running_balance: 0,
           id: "",
           description: "",
           date: "",
           amount: 0,
           account_id: ""

  def generate_transactions(account) do
    days_since_start = Date.diff(Date.utc_today(), account.start_date)

    1..days_since_start
    |> Enum.map(fn day -> create_transaction(day, account) end)
  end

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
  end

  defp get_transaction_amount(day, account) do
    cond do
      rem(day, 7) == 0 ->
        account.inflow
      true ->
        -account.outflow
    end
  end

  defp get_transaction_date(day, account) do
    Date.add(account.start_date, day)
  end

  defp get_txn_id do
    # Shameless copy paste from StackOverflow: https://stackoverflow.com/questions/32001606/how-to-generate-a-random-url-safe-string-with-elixir
    # No uniqness quaranteed
    :crypto.strong_rand_bytes(8) |> Base.url_encode64 |> binary_part(0, 8)
  end
end
