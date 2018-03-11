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
    {:ok, from_json_file(state)}
  end
  # def init(%Model{} = state) do
  #   {:ok, state}
  # end

  @impl true
  def handle_call({:get}, _from, %Model{} = state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:set, %Model{} = new_state}, _state) do
    new_state
      |> to_json_file()

    {:noreply, new_state}
  end

  defp settings_json(), do: "settings.json"

  defp to_json_file(%Model{} = data) do
    File.write!(settings_json(), Poison.encode!(data), [:utf8, :write])
  end

  defp from_json_file(state) do
    case File.read(settings_json()) do
      {:ok, data} ->
          Poison.decode!(data, as: %Model{})

      {:error, _err} ->
        state
    end
  end
end



