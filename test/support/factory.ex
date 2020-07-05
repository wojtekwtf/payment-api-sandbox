defmodule TellerSandboxWeb.Factory do
  def account_factory do
    %TellerSandbox.Account{
      account_number: "1111111111",
      balances: %Balance{
          available: 1111.11,
          ledger: 1111.11
      },
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
      inflow: 1000,
      outflow: 100
    }
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
