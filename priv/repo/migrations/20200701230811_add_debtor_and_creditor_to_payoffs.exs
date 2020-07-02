defmodule DebtManager.Repo.Migrations.AddDebtorAndCreditorToPayoffs do
  use Ecto.Migration

  def change do
    alter table(:payoffs) do
      add :debtor_id, references(:users, on_delete: :nothing)
      add :creditor_id, references(:users, on_delete: :nothing)
    end

    create index(:payoffs, [:debtor_id])
    create index(:payoffs, [:creditor_id])
  end
end
