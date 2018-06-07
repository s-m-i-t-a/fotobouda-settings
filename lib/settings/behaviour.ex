defmodule Settings.Behaviour do
  @moduledoc """
  Define settings behaviour.
  """

  @doc """
  Returns the key under which the data is stored.
  """
  @callback key() :: String.t()

  @doc """
  Init data.
  """
  @callback init() :: any()

  @doc """
  A json subdecoder.
  """
  @callback decoder(settings) :: settings when settings: any()
end
