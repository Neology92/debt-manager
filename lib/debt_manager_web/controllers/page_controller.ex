defmodule DebtManagerWeb.PageController do
  use DebtManagerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
