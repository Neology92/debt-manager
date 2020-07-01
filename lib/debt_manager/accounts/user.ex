defmodule DebtManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :balances, {:array, :map}
    has_many :debts, DebtManager.Flows.Debt
    has_many :payoffs, DebtManager.Flows.Payoff

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :balances])
    |> validate_required([:name, :email, :balances])
  end
end
