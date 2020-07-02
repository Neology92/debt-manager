defmodule DebtManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :balances, {:array, :map}
    has_many :debts, DebtManager.Flows.Debt, foreign_key: :debtor_id
    has_many :lends, DebtManager.Flows.Debt, foreign_key: :creditor_id
    has_many :payoffs, DebtManager.Flows.Payoff, foreign_key: :debtor_id
    has_many :received_payoffs, DebtManager.Flows.Payoff, foreign_key: :creditor_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :balances])
    |> validate_required([:name, :email])
  end
end
