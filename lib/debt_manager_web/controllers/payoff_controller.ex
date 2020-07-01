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
        |> redirect(to: Routes.payoff_path(conn, :show, payoff))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    payoff = Flows.get_payoff!(id)
    render(conn, "show.html", payoff: payoff)
  end

  def edit(conn, %{"id" => id}) do
    payoff = Flows.get_payoff!(id)
    changeset = Flows.change_payoff(payoff)
    render(conn, "edit.html", payoff: payoff, changeset: changeset)
  end

  def update(conn, %{"id" => id, "payoff" => payoff_params}) do
    payoff = Flows.get_payoff!(id)

    case Flows.update_payoff(payoff, payoff_params) do
      {:ok, payoff} ->
        conn
        |> put_flash(:info, "Payoff updated successfully.")
        |> redirect(to: Routes.payoff_path(conn, :show, payoff))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", payoff: payoff, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    payoff = Flows.get_payoff!(id)
    {:ok, _payoff} = Flows.delete_payoff(payoff)

    conn
    |> put_flash(:info, "Payoff deleted successfully.")
    |> redirect(to: Routes.payoff_path(conn, :index))
  end
end
