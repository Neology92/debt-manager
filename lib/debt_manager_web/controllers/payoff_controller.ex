defmodule DebtManagerWeb.PayoffController do
  use DebtManagerWeb, :controller

  alias DebtManager.Flows
  alias DebtManager.Flows.Payoff

  def index(conn, _params) do
    payoffs = Flows.list_payoffs()
    render(conn, "index.html", payoffs: payoffs)
  end

  def new(conn, _params) do
    changeset = Flows.change_payoff(%Payoff{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"payoff" => payoff_params}) do
    case Flows.create_payoff(payoff_params) do
      {:ok, payoff} ->
        conn
        |> put_flash(:info, "Payoff created successfully.")
        |> redirect(to: Routes.page_path(conn, :index, payoff))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
