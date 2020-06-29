defmodule DebtManager.Repo do
  use Ecto.Repo,
    otp_app: :debt_manager,
    adapter: Ecto.Adapters.Postgres
end
