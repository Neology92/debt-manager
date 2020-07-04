defmodule DebtManagerWeb.DashboardController do
  use DebtManagerWeb, :controller
  alias DebtManager.Accounts

  def index(conn, _params) do
    users_list = Accounts.list_users()

    render(conn, "index.html", users: users_list)
  end
end
