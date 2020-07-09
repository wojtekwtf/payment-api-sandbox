defmodule PaymentSandbox.RepoTest do
  use ExUnit.Case

  test "get account by id" do
    # It's awekward to test the data like that, but I think we should do it since we expect it to be static

    assert PaymentSandbox.Repo.get_account_by_id("test_acc_F7lvd56V") == %PaymentSandbox.Account{
             account_number: "1234567891",
             balances: %Balance{available: 300, ledger: 300},
             currency_code: "USD",
             enrollment_id: "test_enr_2yzH_08f",
             id: "test_acc_F7lvd56V",
             institution: %Institution{
               id: "payment_bank",
               name: "The Payment Bank"
             },
             name: "Test 🦁 account",
             links: %AccountLinks{
               self: "http://localhost:4002/accounts/test_acc_F7lvd56V",
               transactions: "http://localhost:4002/accounts/test_acc_F7lvd56V/transactions"
             },
             routing_numbers: %RoutingNumbers{
               ach: "123456789",
               wire: "123456789"
             },
             inflow: 1000,
             outflow: 100,
             start_date: ~D[2020-07-01]
           }

    assert PaymentSandbox.Repo.get_account_by_id("test_acc_G8mwe67W") == %PaymentSandbox.Account{
             account_number: "1234567892",
             balances: %Balance{available: 200, ledger: 200},
             currency_code: "USD",
             enrollment_id: "test_enr_3zaI_19g",
             id: "test_acc_G8mwe67W",
             institution: %Institution{
               id: "wojciech_bank",
               name: "The Wojciech Bank"
             },
             name: "Test 🐸 account",
             links: %AccountLinks{
               self: "http://localhost:4002/accounts/test_acc_G8mwe67W",
               transactions: "http://localhost:4002/accounts/test_acc_G8mwe67W/transactions"
             },
             routing_numbers: %RoutingNumbers{
               ach: "234567891",
               wire: "234567891"
             },
             inflow: 700,
             outflow: 100,
             start_date: ~D[2020-06-01]
           }

    assert PaymentSandbox.Repo.get_account_by_id("test_acc_H9nxf78X") == %PaymentSandbox.Account{
             account_number: "1234567893",
             balances: %Balance{available: 900, ledger: 900},
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
             links: %AccountLinks{
               self: "http://localhost:4002/accounts/test_acc_H9nxf78X",
               transactions: "http://localhost:4002/accounts/test_acc_H9nxf78X/transactions"
             },
             inflow: 2100,
             outflow: 300,
             start_date: ~D[2020-05-01]
           }

    assert PaymentSandbox.Repo.get_account_by_id("test_acc_I0myg89Y") == %PaymentSandbox.Account{
             account_number: "1234567894",
             balances: %Balance{available: 69500, ledger: 69500},
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
             links: %AccountLinks{
               self: "http://localhost:4002/accounts/test_acc_I0myg89Y",
               transactions: "http://localhost:4002/accounts/test_acc_I0myg89Y/transactions"
             },
             inflow: 8000,
             outflow: 500,
             start_date: ~D[2020-04-01]
           }

    assert PaymentSandbox.Repo.get_account_by_id("test_acc_J1nzh90Z") == %PaymentSandbox.Account{
             account_number: "1234567895",
             balances: %Balance{available: 96800, ledger: 96800},
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
             links: %AccountLinks{
               self: "http://localhost:4002/accounts/test_acc_J1nzh90Z",
               transactions: "http://localhost:4002/accounts/test_acc_J1nzh90Z/transactions"
             },
             inflow: 6000,
             outflow: 100,
             start_date: ~D[2020-03-01]
           }
  end

  test "account not found" do
    assert PaymentSandbox.Repo.get_account_by_id("I don't exist") == nil
  end
end
