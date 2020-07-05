defmodule DebtManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # Use .env in dev
    unless Mix.env() == :prod do
      Envy.auto_load()
      Envy.reload_config()
    end

    children = [
      # Start the Ecto repository
      DebtManager.Repo,
      # Start the Telemetry supervisor
      DebtManagerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DebtManager.PubSub},
      # Start the Endpoint (http/https)
      DebtManagerWeb.Endpoint
      # Start a worker by calling: DebtManager.Worker.start_link(arg)
      # {DebtManager.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DebtManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DebtManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
