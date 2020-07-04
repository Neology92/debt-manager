defmodule DebtManagerWeb.PayoffController do
  use DebtManagerWeb, :controller

  alias DebtManager.Flows
  alias DebtManager.Flows.Payoff
  alias DebtManager.Accounts

  def index(conn, _params) do
    payoffs = Flows.list_payoffs()
    render(conn, "index.html", payoffs: payoffs)
  end

  def new(conn, _params) do
    changeset = Flows.change_payoff(%Payoff{})
    users = Accounts.list_users()

    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(%{assigns: %{current_user: user}} = conn, %{"payoff" => payoff_params}) do
    {creditor_id, params} = Map.pop(payoff_params, "creditor_id")
    creditor_id = String.to_integer(creditor_id)

    case Flows.create_payoff(params, user, creditor_id) do
      {:ok, _payoff} ->
        conn
        |> put_flash(:info, "Payoff created successfully.")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
