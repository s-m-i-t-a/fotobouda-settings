defmodule Settings.Model do
  @moduledoc """
  Model structure and defaults.
  """

  @type t() :: map()

  @spec create([atom()]) :: t()
  def create(modules) do
    Enum.reduce(modules, %{}, fn(module, acc) -> Map.put_new(acc, module.key(), module.init()) end)
  end

  @spec add(t(), atom()) :: t()
  def add(model, module) do
    Map.put_new(model, module.key(), module.init())
  end

  @spec decode(map(), [atom()]) :: t()
  def decode(value, modules) do
    Enum.reduce(modules, value, fn(module, acc) -> module.decoder(acc) end)
  end
end
