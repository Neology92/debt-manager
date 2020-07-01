defmodule DebtManager.Repo.Migrations.CreatePayoffs do
  use Ecto.Migration

  def change do
    create table(:payoffs) do
      add :title, :string
      add :amount, :float

      timestamps()
    end
  end
end
