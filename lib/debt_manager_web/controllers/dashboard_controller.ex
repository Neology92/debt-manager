defmodule DebtManagerWeb.DashboardController do
  use DebtManagerWeb, :controller
  alias DebtManager.Accounts
  alias DebtManager.Flows

  def index(conn, _params) do
    users_list = get_users_names_list()

    render(conn, "index.html", users: users_list)
  end

  def history(conn, %{"id" => fellow_id}) do
    debts = Flows.get_debts_between_users(conn.assigns.current_user.id, fellow_id)
    # TODO: Same pattern with payoffs
    users_list = get_users_names_list()

    render(conn, "history.html", debts: debts, users: users_list)
  end

  defp get_users_names_list() do
    Accounts.list_users()
    |> Enum.map(fn u -> %{u.id => u.name} end)
    |> Enum.reduce(fn x, y -> Map.merge(x, y) end)
  end
end
