defmodule TellerSandboxWeb.Factory do
  def account_factory(inflow \\ 600, outflow \\ 100, start_date \\ ~D[2020-06-06]) do # TODO improve the factory
    %TellerSandbox.Account{
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
          wire: "1111111111"
      },
      inflow: inflow,
      outflow: outflow,
      start_date: start_date
    }
  end

  def account_factory_with_balance(inflow \\ 600, outflow \\ 100, start_date \\ ~D[2020-06-06]) do
    account_factory(inflow, outflow, start_date)
    |> TellerSandbox.Account.set_balances()
  end

  def transaction_factory do
    %TellerSandbox.Transaction{
      type: "card_payment",
      running_balance: 1000,
      id: "test_txn_1",
      description: "test",
      date: "",
      amount: 100,
      account_id: "test_acc_11111111"
    }
  end
end
