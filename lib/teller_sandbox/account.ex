defmodule Balance do
  @derive Jason.Encoder
  defstruct [:available, :ledger]

  @type t :: %Balance{
          available: number,
          ledger: number
        }

  @spec get_account_balance(PaymentSandbox.Account.t(), Date.t()) :: Balance.t()
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
  defstruct [:id, :name]

  @type t :: %Institution{
          id: String.t(),
          name: String.t()
        }
end

defmodule RoutingNumbers do
  @derive Jason.Encoder
  defstruct [:ach, :wire]

  @type t :: %RoutingNumbers{
          ach: String.t(),
          wire: String.t()
        }
end

defmodule AccountLinks do
  @derive Jason.Encoder
  defstruct [:self, :transactions]

  @type t :: %AccountLinks{
          self: String.t(),
          transactions: String.t()
        }

  @spec get_account_links(PaymentSandbox.Account.t()) :: AccountLinks.t()
  def get_account_links(account) do
    %AccountLinks{
      self: PaymentSandboxWeb.Endpoint.url() <> "/accounts/" <> account.id,
      transactions:
        PaymentSandboxWeb.Endpoint.url() <> "/accounts/" <> account.id <> "/transactions"
    }
  end
end

defmodule PaymentSandbox.Account do
  @derive {Jason.Encoder,
           only: [
             :account_number,
             :balances,
             :currency_code,
             :enrollment_id,
             :id,
             :institution,
             :links,
             :name,
             :routing_numbers
           ]}

  defstruct [
    :account_number,
    :balances,
    :currency_code,
    :enrollment_id,
    :id,
    :institution,
    :name,
    :routing_numbers,
    :inflow,
    :outflow,
    :links,
    :start_date
  ]

  @type t :: %PaymentSandbox.Account{
          account_number: String.t(),
          balances: Balance.t() | nil,
          currency_code: String.t(),
          enrollment_id: String.t(),
          id: String.t(),
          institution: Institution.t(),
          name: String.t(),
          routing_numbers: RoutingNumbers.t(),
          inflow: number,
          outflow: number,
          links: AccountLinks.t() | nil,
          start_date: Date.t()
        }

  @spec set_account_balance(PaymentSandbox.Account.t(), Date.t()) :: PaymentSandbox.Account.t()
  def set_account_balance(account, end_date \\ Date.utc_today()) do
    %{account | balances: Balance.get_account_balance(account, end_date)}
  end

  @spec set_links(PaymentSandbox.Account.t()) :: PaymentSandbox.Account.t()
  def set_links(account) do
    %{account | links: AccountLinks.get_account_links(account)}
  end
end
