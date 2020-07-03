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

  def show(conn, %{"id" => id}) do
    debt = Flows.get_debt!(id)
    render(conn, "show.html", debt: debt)
  end

  def edit(conn, %{"id" => id}) do
    debt = Flows.get_debt!(id)
    changeset = Flows.change_debt(debt)
    render(conn, "edit.html", debt: debt, changeset: changeset)
  end

  def update(conn, %{"id" => id, "debt" => debt_params}) do
    debt = Flows.get_debt!(id)

    case Flows.update_debt(debt, debt_params) do
      {:ok, debt} ->
        conn
        |> put_flash(:info, "Debt updated successfully.")
        |> redirect(to: Routes.debt_path(conn, :show, debt))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", debt: debt, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    debt = Flows.get_debt!(id)
    {:ok, _debt} = Flows.delete_debt(debt)

    conn
    |> put_flash(:info, "Debt deleted successfully.")
    |> redirect(to: Routes.debt_path(conn, :index))
  end
end
