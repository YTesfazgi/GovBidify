defmodule GovBidifyWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :gov_bidify

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_gov_bidify_key",
    signing_salt: "4EtNgo9Q",
    same_site: "Lax"
  ]

  # Enable SQL sandbox for development environments.
  # You should not set this in production as keeping
  # the DB in a consistent state is critical.

  if sandbox = Application.compile_env(:gov_bidify, :sandbox, false) do
    plug Phoenix.Ecto.SQL.Sandbox, sandbox: sandbox
  end

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :gov_bidify,
    gzip: false,
    only: GovBidifyWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :gov_bidify
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug GovBidifyWeb.Router
end
