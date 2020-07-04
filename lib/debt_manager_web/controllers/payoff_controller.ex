defmodule DebtManagerWeb.PayoffController do
  use DebtManagerWeb, :controller

  alias DebtManager.Flows
  alias DebtManager.Flows.Payoff
  alias DebtManager.Accounts

  def index(conn, _params) do
    payoffs = Flows.list_payoffs()
    render(conn, "index.html", payoffs: payoffs)
  end

  def new(conn, params) do
    changeset = Flows.change_payoff(%Payoff{})

    default_option = if params && params["id"], do: params["id"], else: 0

    options = Accounts.generate_users_options(conn.assigns.current_user)

    render(conn, "new.html",
      changeset: changeset,
      options: options,
      default_option: default_option
    )
  end

  def create(%{assigns: %{current_user: user}} = conn, %{"payoff" => payoff_params} = params) do
    {creditor_id, payoff_params} = Map.pop(payoff_params, "creditor_id")
    creditor_id = String.to_integer(creditor_id)

    case Flows.create_payoff(payoff_params, user, creditor_id) do
      {:ok, _payoff} ->
        conn
        |> put_flash(:info, "Payoff created successfully.")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        options = Accounts.generate_users_options(conn.assigns.current_user)
        default_option = if params && params["id"], do: params["id"], else: 0

        render(conn, "new.html",
          changeset: changeset,
          options: options,
          default_option: default_option
        )
    end
  end
end
