defmodule Balance do
  @derive Jason.Encoder
  defstruct available: 0, ledger: 0

  def get_account_balance(account, end_date \\ Date.utc_today()) do
    account_age_days = Date.diff(end_date, account.start_date)

    inflow_days = div(account_age_days, 7)

    total_outflow = (account_age_days - inflow_days) * account.outflow
    total_inflow = inflow_days * account.inflow

    balance = total_inflow - total_outflow

    %Balance{
      available: balance,
      ledger: balance
    }
  end
end

defmodule Institution do
  @derive Jason.Encoder
  defstruct id: "", name: ""
end

defmodule RoutingNumbers do
  @derive Jason.Encoder
  defstruct ach: "", wire: ""
end

defmodule TellerSandbox.Account do
  @derive {Jason.Encoder,
           only: [
             :account_number,
             :balances,
             :currency_code,
             :enrollment_id,
             :id,
             :institution,
             :name,
             :routing_numbers
           ]}
  defstruct account_number: "",
            balances: %Balance{},
            currency_code: "USD",
            enrollment_id: "",
            id: "",
            institution: %Institution{},
            name: "",
            routing_numbers: %RoutingNumbers{},
            inflow: 0,
            outflow: 0,
            start_date: Date.utc_today()

  def set_account_balance(account, end_date \\ Date.utc_today()) do
    %{account | balances: Balance.get_account_balance(account, end_date)}
  end
end
