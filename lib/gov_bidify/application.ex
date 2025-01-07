defmodule GovBidify.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GovBidifyWeb.Telemetry,
      # Start the Ecto repository
      GovBidify.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: GovBidify.PubSub},
      # Start Finch
      {Finch, name: GovBidify.Finch},
      # Start the Endpoint (http/https)
      GovBidifyWeb.Endpoint,
      # Start Cachex
      {Cachex, name: :combobox_cache},
      # Start the NAICS parser
      {GovBidify.NAICS_Parser, []},
      # Start the PSC parser
      {GovBidify.PSC_Parser, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GovBidify.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GovBidifyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
