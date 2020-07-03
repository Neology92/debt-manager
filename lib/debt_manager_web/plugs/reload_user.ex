defmodule DebtManagerWeb.ReloadUserPlug do
  @doc false

  @spec init(any()) :: any()
  def init(opts), do: opts

  @doc false
  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    config = Pow.Plug.fetch_config(conn)

    case Pow.Plug.current_user(conn, config) do
      nil ->
        conn

      user ->
        reloaded_user = DebtManager.Accounts.get_user!(user.id)
        Pow.Plug.assign_current_user(conn, reloaded_user, config)
    end
  end
end
