defmodule DebtManagerWeb.MailerController do
  use DebtManagerWeb, :controller

  alias DebtManager.Mailer
  alias DebtManager.Accounts

  def send_urge(%{assigns: %{current_user: user}} = conn, %{"id" => id}) do
    debtors_list =
      if id == "0" do
        Enum.filter(user.balances, fn {_id, x} -> x > 0 end)
        |> Enum.map(fn {id, _x} -> id end)
      else
        [id]
      end

    if Enum.count(debtors_list) == 0 do
      conn
      |> put_flash(:info, "You don't have debtors.")
      |> redirect(to: Routes.dashboard_path(conn, :index))
    end

    emails =
      for id <- debtors_list do
        %{email: email} = Accounts.get_user!(id)
        email
      end

    case Mailer.send_urge_emails(user.name, emails) do
      :ok ->
        conn
        |> put_flash(:info, "Sent successfully.")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      :error ->
        conn
        |> put_flash(:warning, "Something went wrong.")
        |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end
end
