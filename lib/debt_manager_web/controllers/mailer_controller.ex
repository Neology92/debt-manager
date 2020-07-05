defmodule DebtManagerWeb.MailerController do
  use DebtManagerWeb, :controller

  alias DebtManager.Mailer

  def send_urge(conn, _params) do
    email = "oskarlegner@gmail.com"

    case Mailer.send_urge_email(conn.assigns.current_user.name, email) do
      {:ok, _mail} ->
        conn
        |> put_flash(:info, "Email sent successfully.")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, _, _} ->
        conn
        |> put_flash(:warning, "Something went wrong. Mail have not been sent.")
        |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end
end
