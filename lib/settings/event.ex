defmodule Settings.Event do
  @moduledoc """
  Event model structure.
  """

  @behaviour Settings.Behaviour

  @impl true
  def key() do
    Atom.to_string(__MODULE__)
  end

  @impl true
  def init() do
    ""
  end

  @impl true
  def decoder(name) do
    name
  end

  @spec put_name_event(Settings.Model.t(), String.t()) :: Settings.Model.t()
  def put_name_event(model, name) do
    %{model | name_event: name}
  end
end
