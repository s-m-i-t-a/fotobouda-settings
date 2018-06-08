defmodule MySettings do
  @moduledoc false
  @behaviour Settings.Behaviour

  @impl true
  def key() do
    Atom.to_string(__MODULE__)
  end

  @impl true
  def init() do
    :test
  end

  @impl true
  def decoder(settings) do
    update_in(settings, [key()], &String.to_atom/1)
  end
end
