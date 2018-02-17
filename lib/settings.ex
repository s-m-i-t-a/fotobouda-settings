defmodule Settings do
  @moduledoc """
  Settings public API
  """

  alias Settings.{Model, Server}

  def get() do
    GenServer.call(Server, {:get})
  end

  def set(%Model{} = model) do
    GenServer.cast(Server, {:set, model})
  end
end
