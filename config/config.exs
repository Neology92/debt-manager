# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :debt_manager,
  ecto_repos: [DebtManager.Repo]

# Configures the endpoint
config :debt_manager, DebtManagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eks/zpAX+427sQ/OMOBFjFmhLeCzinpOyYYiO4b21X2hSe7NWRaVgYWlDN4GKz1M",
  render_errors: [view: DebtManagerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DebtManager.PubSub,
  live_view: [signing_salt: "8QgnfifC"]

# Configures Pow (auth library)
config :debt_manager, :pow,
  user: DebtManager.Accounts.User,
  repo: DebtManager.Repo,
  web_module: DebtManagerWeb

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config mailgun
config :debt_manager,
  mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key: System.get_env("MAILGUN_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
