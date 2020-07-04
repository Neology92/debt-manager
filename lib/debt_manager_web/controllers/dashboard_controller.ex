defmodule DebtManagerWeb.DashboardController do
  use DebtManagerWeb, :controller
  alias DebtManager.Accounts
  alias DebtManager.Flows

  def index(conn, _params) do
    users_list = Accounts.list_users()

    render(conn, "index.html", users: users_list)
  end

  def history(conn, %{"id" => fellow_id}) do
    debts = Flows.get_debts_between_users(conn.assigns.current_user.id, fellow_id)
    # TODO: Same pattern with payoffs

    render(conn, "history.html", debts: debts)
  end
end
