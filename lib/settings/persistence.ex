defmodule Settings.Persistence do
  @moduledoc """
  Saving and loading data from json file.
  """

  alias Settings.Model

  @settings_json "settings.json"

  def to_json_file(data) do
    File.write!(@settings_json, Poison.encode!(data), [:utf8, :write])
  end

  def from_json_file(state, modules) do
    @settings_json
    |> File.read()
    |> Result.and_then(&Poison.decode/1)
    |> Result.map(fn (value) -> Model.decode(value, modules) end)
    |> Result.with_default(state)
  end
end
