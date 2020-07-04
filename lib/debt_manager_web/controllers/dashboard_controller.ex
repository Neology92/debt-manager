defmodule DebtManagerWeb.DashboardController do
  use DebtManagerWeb, :controller
  alias DebtManager.Flows
  alias DebtManager.Accounts

  def index(conn, _params) do
    users_list = Accounts.get_users_names_list()

    render(conn, "index.html", users: users_list)
  end

  def history(conn, %{"id" => fellow_id}) do
    debts =
      Flows.get_debts_between_users(conn.assigns.current_user.id, fellow_id)
      |> Enum.reverse()

    payoffs =
      Flows.get_payoffs_between_users(conn.assigns.current_user.id, fellow_id)
      |> Enum.reverse()

    users_list = Accounts.get_users_names_list()

    render(conn, "history.html", debts: debts, payoffs: payoffs, users: users_list)
  end
end
