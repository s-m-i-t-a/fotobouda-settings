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
  def start_link(modules) do
    Logger.info(fn -> "Settings server started..." end)
    GenServer.start_link(__MODULE__, modules, name: __MODULE__)
  end

  @impl true
  def init(modules) do
    state = Model.create(modules)
    {:ok, {modules, Persistence.from_json_file(state, modules)}}
  end

  @impl true
  def handle_call({:get, fun}, _from, {_modules, model} = state) do
    {:reply, apply(fun, [model]), state}
  end

  @impl true
  def handle_call({:get_and_update, fun}, _from, {modules, model}) do
    {value, new_model} = apply(fun, [model])

    # update file
    Persistence.to_json_file(new_model)

    {:reply, value, {modules, new_model}}
  end

  @impl true
  def handle_call({:update, fun}, _from, {modules, model}) do
    new_model = apply(fun, [model])

    # update file
    Persistence.to_json_file(new_model)

    {:reply, :ok, {modules, new_model}}
  end

  # API

  @spec get((Model.t() -> a)) :: a when a: var
  def get(fun) do
    GenServer.call(__MODULE__, {:get, fun})
  end

  @spec get_and_update((Model.t() -> {a, Model.t()})) :: a when a: var
  def get_and_update(fun) do
    GenServer.call(__MODULE__, {:get_and_update, fun})
  end

  @spec update((Model.t() -> Model.t())) :: :ok
  def update(fun) do
    GenServer.call(__MODULE__, {:update, fun})
  end
end
