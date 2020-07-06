defmodule TellerSandbox.BalanceTest do
  use ExUnit.Case

  test "calculate balance" do
    today = ~D[2020-06-30]
    account_1 = TellerSandboxWeb.Factory.account_factory(600, 100, ~D[2020-06-06])
    account_2 = TellerSandboxWeb.Factory.account_factory(1000, 5, ~D[2020-06-25])
    account_3 = TellerSandboxWeb.Factory.account_factory(0, 100, ~D[2020-06-01])
    account_4 = TellerSandboxWeb.Factory.account_factory(2000, 100, ~D[2020-06-23])
    assert Balance.get_account_balance(account_1, today) == %Balance{available: -300, ledger: -300}
    assert Balance.get_account_balance(account_2, today) == %Balance{available: -25, ledger: -25}
    assert Balance.get_account_balance(account_3, today) == %Balance{available: -2500, ledger: -2500}
    assert Balance.get_account_balance(account_4, today) == %Balance{available: 1400, ledger: 1400}
  end
end
