defmodule DebtManager.Flows.Debt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "debts" do
    field :title, :string
    field :amount, :float
    belongs_to :debtor, DebtManager.Accounts.User
    belongs_to :creditor, DebtManager.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(debt, attrs) do
    debt
    |> cast(attrs, [:title, :amount])
    |> validate_required([:title, :amount])
  end
end
