defmodule DebtManager.Flows.Payoff do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payoffs" do
    field :title, :string
    field :amount, :float
    belongs_to :debtor, DebtManager.Accounts.User, foreign_key: :debtor_id
    belongs_to :creditor, DebtManager.Accounts.User, foreign_key: :creditor_id

    timestamps()
  end

  @doc false
  def changeset(payoff, attrs) do
    payoff
    |> cast(attrs, [:title, :amount])
    |> validate_required([:title, :amount])
  end
end
