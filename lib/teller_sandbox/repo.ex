defmodule PaymentSandbox.Repo do
  @spec get_all_accounts :: [PaymentSandbox.Account.t()]
  def get_all_accounts() do
    [
      %PaymentSandbox.Account{
        account_number: "1234567891",
        currency_code: "USD",
        enrollment_id: "test_enr_2yzH_08f",
        id: "test_acc_F7lvd56V",
        institution: %Institution{
          id: "payment_bank",
          name: "The Payment Bank"
        },
        name: "Test 🦁 account",
        routing_numbers: %RoutingNumbers{
          ach: "123456789",
          wire: "123456789"
        },
        inflow: 1000,
        outflow: 100,
        start_date: ~D[2020-07-01]
      },
      %PaymentSandbox.Account{
        account_number: "1234567892",
        currency_code: "USD",
        enrollment_id: "test_enr_3zaI_19g",
        id: "test_acc_G8mwe67W",
        institution: %Institution{
          id: "wojciech_bank",
          name: "The Wojciech Bank"
        },
        name: "Test 🐸 account",
        routing_numbers: %RoutingNumbers{
          ach: "234567891",
          wire: "234567891"
        },
        inflow: 700,
        outflow: 100,
        start_date: ~D[2020-06-01]
      },
      %PaymentSandbox.Account{
        account_number: "1234567893",
        currency_code: "USD",
        enrollment_id: "test_enr_4abJ_20h",
        id: "test_acc_H9nxf78X",
        institution: %Institution{
          id: "twitter_bank",
          name: "The Twitter Bank"
        },
        name: "Test 🐻 account",
        routing_numbers: %RoutingNumbers{
          ach: "345678912",
          wire: "345678912"
        },
        inflow: 2100,
        outflow: 300,
        start_date: ~D[2020-05-01]
      },
      %PaymentSandbox.Account{
        account_number: "1234567894",
        currency_code: "USD",
        enrollment_id: "test_enr_5bcK_31i",
        id: "test_acc_I0myg89Y",
        institution: %Institution{
          id: "lfc_bank",
          name: "The Liverpool Bank"
        },
        name: "Test 🐼 account",
        routing_numbers: %RoutingNumbers{
          ach: "456789123",
          wire: "456789123"
        },
        inflow: 8000,
        outflow: 500,
        start_date: ~D[2020-04-01]
      },
      %PaymentSandbox.Account{
        account_number: "1234567895",
        currency_code: "USD",
        enrollment_id: "test_enr_6cdL_42j",
        id: "test_acc_J1nzh90Z",
        institution: %Institution{
          id: "berghain_bank",
          name: "The Berghain Bank"
        },
        name: "Test 👁👄👁 account",
        routing_numbers: %RoutingNumbers{
          ach: "567891234",
          wire: "567891234"
        },
        inflow: 6000,
        outflow: 100,
        start_date: ~D[2020-03-01]
      }
    ]
    |> Enum.map(fn account -> PaymentSandbox.Account.set_account_balance(account) end)
    |> Enum.map(fn account -> PaymentSandbox.Account.set_links(account) end)
  end

  @spec get_account_by_id(String.t()) :: PaymentSandbox.Account.t() | nil
  def get_account_by_id(account_id) do
    get_all_accounts()
    |> Enum.find(fn account -> account.id == account_id end)
  end

  @spec get_account_transactions(PaymentSandbox.Account.t()) :: [PaymentSandbox.Transaction.t()]
  def get_account_transactions(account) do
    PaymentSandbox.Transaction.generate_transactions(account)
  end
end
