defmodule Meetup.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MeetupWeb.Telemetry,
      Meetup.Repo,
      {DNSCluster, query: Application.get_env(:meetup, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Meetup.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Meetup.Finch},
      # Start a worker by calling: Meetup.Worker.start_link(arg)
      # {Meetup.Worker, arg},
      # Start to serve requests, typically the last entry
      MeetupWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Meetup.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MeetupWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
