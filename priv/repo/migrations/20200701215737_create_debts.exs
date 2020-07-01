defmodule DebtManager.Repo.Migrations.CreateDebts do
  use Ecto.Migration

  def change do
    create table(:debts) do
      add :title, :string
      add :amount, :float

      timestamps()
    end
  end
end
