defmodule PaymentSandboxWeb.Factory do
  @spec account_factory(number(), number(), Date.t()) :: PaymentSandbox.Account.t()
  def account_factory(inflow \\ 600, outflow \\ 100, start_date \\ ~D[2020-06-06]) do
    %PaymentSandbox.Account{
      account_number: "1111111111",
      currency_code: "USD",
      enrollment_id: "test_enr_11111111",
      id: "test_acc_11111111",
      institution: %Institution{
        id: "test_bank",
        name: "The Test Bank"
      },
      name: "Test account",
      routing_numbers: %RoutingNumbers{
        ach: "111111111",
        wire: "111111111"
      },
      inflow: inflow,
      outflow: outflow,
      start_date: start_date
    }
  end

  @spec transaction_factory :: PaymentSandbox.Transaction.t()
  def transaction_factory do
    %PaymentSandbox.Transaction{
      type: "card_payment",
      running_balance: :rand.uniform(10000),
      id: "test_txn_12345678",
      description: "test",
      date: ~D[2020-01-01],
      amount: :rand.uniform(10000),
      account_id: "test_acc_11111111"
    }
  end
end
