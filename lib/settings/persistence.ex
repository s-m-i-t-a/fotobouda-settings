defmodule Settings.Persistence do
  @moduledoc """
  Saving and loading data from json file.
  """

  alias Settings.Model

  @settings_json "settings.json"

  def to_json_file(%Model{} = data) do
    File.write!(@settings_json, Poison.encode!(data), [:utf8, :write])
  end

  def from_json_file(state) do
    case File.read(@settings_json) do
      {:ok, data} ->
        decode_data = Poison.decode!(data, as: %Model{})

        decode_data
        |> Map.get(:social_media)
        |> Model.media_to_atom()
        |> (&Map.replace!(decode_data, :social_media, &1)).()

      {:error, _err} ->
        state
    end
  end
end
