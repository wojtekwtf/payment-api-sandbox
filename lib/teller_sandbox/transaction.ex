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
    cond do
      rem(day, 7) == 0 ->
        %TellerSandbox.Transaction{
          type: "card_payment",
          running_balance: 1000, # TODO
          id: "test_txn_12345678", # TODO
          description: "test",
          date: "2020-07-07", # TODO
          amount: account.inflow,
          account_id: account.id
        }
      true ->
        %TellerSandbox.Transaction{
          type: "card_payment",
          running_balance: 1000, # TODO
          id: "test_txn_12345678", # TODO
          description: "test",
          date: "2020-07-07", # TODO
          amount: -account.outflow,
          account_id: account.id
        }
    end
  end
end
