defmodule Settings do
  @moduledoc """
  Settings public API
  """

  alias Settings.Server

  defdelegate get(fun), to: Server
  defdelegate get_and_update(fun), to: Server
  defdelegate update(fun), to: Server
end
