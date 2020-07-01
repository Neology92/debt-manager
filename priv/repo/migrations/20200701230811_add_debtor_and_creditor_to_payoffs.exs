defmodule DebtManager.Repo.Migrations.AddDebtorAndCreditorToDebts do
  use Ecto.Migration

  def change do
    alter table(:payoffs) do
      add :debtor_user_id, references(:users, on_delete: :nothing)
      add :creditor_user_id, references(:users, on_delete: :nothing)
    end

    # create index(:payoffs, [:debtor_user_id])
    # create index(:payoffs, [:creditor_user_id])
  end
end
