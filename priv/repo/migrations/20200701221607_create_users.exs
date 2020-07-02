defmodule DebtManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :balances, :map

      timestamps()
    end
  end
end
