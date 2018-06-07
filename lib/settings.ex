defmodule Settings do
  @moduledoc """
  Settings public API
  """

  alias Settings.Server

  def get() do
    GenServer.call(Server, {:get})
  end

  # def set(%Model{} = model) do
  def set(model) do
    GenServer.cast(Server, {:set, model})
  end
end
