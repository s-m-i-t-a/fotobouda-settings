defmodule Settings.Server do
  @moduledoc """
  Settings state server.
  """
  use GenServer

  alias Settings.Settings

  require Logger

  # Server
  #
  @doc false
  def start_link(settings \\ %Settings{}) do
    Logger.info(fn -> "Settings server started..." end)
    GenServer.start_link(__MODULE__, settings, name: __MODULE__)
  end

  @impl true
  def init(%Settings{} = state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:get}, _from, %Settings{} = state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:set, %Settings{} = new_state}, _state) do
    {:noreply, new_state}
  end
end
