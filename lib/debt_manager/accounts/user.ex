defmodule DebtManager.Accounts.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    pow_user_fields()
    field :name, :string
    field :balances, :map, default: %{}
    has_many :debts, DebtManager.Flows.Debt, foreign_key: :debtor_id
    has_many :lends, DebtManager.Flows.Debt, foreign_key: :creditor_id
    has_many :payoffs, DebtManager.Flows.Payoff, foreign_key: :debtor_id
    has_many :received_payoffs, DebtManager.Flows.Payoff, foreign_key: :creditor_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
