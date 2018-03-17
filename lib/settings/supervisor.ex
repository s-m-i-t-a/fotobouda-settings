defmodule Settings.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(args \\ []) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: CameraControl.Worker.start_link(arg)
      {Settings.Server, %Settings.Model{}},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one]
    Supervisor.init(children, opts)
  end
end
