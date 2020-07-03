defmodule DebtManagerWeb.DebtController do
  use DebtManagerWeb, :controller

  alias DebtManager.Flows
  alias DebtManager.Flows.Debt
  alias DebtManager.Accounts

  def index(conn, _params) do
    debts = Flows.list_debts()
    render(conn, "index.html", debts: debts)
  end

  def new(conn, _params) do
    changeset = Flows.change_debt(%Debt{})
    users = Accounts.list_users()

    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"debt" => debt_params}) do
    # TODO: put there current, signed in user!
    user = Accounts.get_user!(1)

    {debtor_id, params} = Map.pop(debt_params, "debtor_id")
    debtor_id = String.to_integer(debtor_id)

    case Flows.create_debt(params, user, debtor_id) do
      {:ok, debt} ->
        conn
        |> put_flash(:info, "Debt created successfully.")
        |> redirect(to: Routes.page_path(conn, :index, debt))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
