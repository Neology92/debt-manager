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

    options = Accounts.generate_users_options(conn.assigns.current_user)

    render(conn, "new.html", changeset: changeset, options: options)
  end

  def create(%{assigns: %{current_user: user}} = conn, %{"debt" => debt_params}) do
    {debtor_id, params} = Map.pop(debt_params, "debtor_id")
    debtor_id = String.to_integer(debtor_id)

    case Flows.create_debt(params, user, debtor_id) do
      {:ok, _debt} ->
        conn
        |> put_flash(:info, "Debt created successfully.")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        options = Accounts.generate_users_options(conn.assigns.current_user)

        render(conn, "new.html", changeset: changeset, options: options)
    end
  end
end
