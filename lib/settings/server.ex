defmodule Settings.Server do
  @moduledoc """
  Settings state server.
  """
  use GenServer

  alias Settings.{Model, Persistence}

  require Logger

  # Server
  #
  @doc false
  def start_link(model \\ Model.create()) do
    Logger.info(fn -> "Model server started..." end)
    GenServer.start_link(__MODULE__, model, name: __MODULE__)
  end

  @impl true
  def init(state) do
    Persistence.from_json_file(state)
  end

  @impl true
  def handle_call({:get}, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:set, new_state}, _state) do
    new_state
      |> Persistence.to_json_file()

    {:noreply, new_state}
  end
end
