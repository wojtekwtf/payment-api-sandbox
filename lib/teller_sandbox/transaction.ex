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
end
