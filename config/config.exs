# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :gov_bidify,
  ecto_repos: [GovBidify.Repo]

# Configures the endpoint
config :gov_bidify, GovBidifyWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: GovBidifyWeb.ErrorHTML, json: GovBidifyWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: GovBidify.PubSub,
  live_view: [signing_salt: "1HR2b3Jj"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :gov_bidify, GovBidify.Mailer, adapter: Swoosh.Adapters.Local

config :gov_bidify, sam_api_key: "OHeWlE35lxgbbYlXgkVVHesZ7GkJw8aruymLAatT"

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

# Configures tzdata
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Configures flop
config :flop, repo: GovBidify.Repo
