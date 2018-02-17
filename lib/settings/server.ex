defmodule Settings.Server do
  @moduledoc """
  Settings state server.
  """
  use GenServer

  alias Settings.Model

  require Logger

  # Server
  #
  @doc false
  def start_link(model \\ %Model{}) do
    Logger.info(fn -> "Model server started..." end)
    GenServer.start_link(__MODULE__, model, name: __MODULE__)
  end

  @impl true
  def init(%Model{} = state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:get}, _from, %Model{} = state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:set, %Model{} = new_state}, _state) do
    {:noreply, new_state}
  end
end
