defmodule Settings do
  @moduledoc """
  Settings public API
  """

  alias Settings.{Settings, Server}

  def get() do
    GenServer.call(Server, {:get})
  end

  def set(%Settings{} = settings) do
    GenServer.cast(Server, {:set, settings})
  end
end
