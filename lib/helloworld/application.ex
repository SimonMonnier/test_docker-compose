defmodule Helloworld.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Helloworld.Repo,
      # Start the Telemetry supervisor
      HelloworldWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Helloworld.PubSub},
      # Start the Endpoint (http/https)
      HelloworldWeb.Endpoint
      # Start a worker by calling: Helloworld.Worker.start_link(arg)
      # {Helloworld.Worker, arg}
    ]
    
    # Existing code
    # Existing code
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Helloworld.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloworldWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
