defmodule JoinBoxJack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JoinBoxJackWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:join_box_jack, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JoinBoxJack.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: JoinBoxJack.Finch},
      # Start a worker by calling: JoinBoxJack.Worker.start_link(arg)
      # {JoinBoxJack.Worker, arg},
      # Start to serve requests, typically the last entry
      JoinBoxJackWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JoinBoxJack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JoinBoxJackWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
