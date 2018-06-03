defmodule Settings.Persistence do
  @moduledoc """
  Saving and loading data from json file.
  """

  alias Settings.{Model, QrCode}

  @settings_json "settings.json"

  def to_json_file(%Model{} = data) do
    File.write!(@settings_json, Poison.encode!(data), [:utf8, :write])
  end

  def from_json_file(state) do
    @settings_json
    |> File.read()
    |> decode_data()
    |> update_social_media_to_atom()
    |> return_state(state)
  end

  defp decode_data({:ok, data}) do
    Poison.decode(data, as: %Model{})
  end

  defp decode_data(err) do
    err
  end

  defp update_social_media_to_atom({:ok, data}) do
    {:ok, social_media} =
      data
      |> get_social_media()
      |> Model.media_to_atom()


    {:ok, Map.replace!(data, :social_media, social_media)}
  end

  defp update_social_media_to_atom(err) do
    err
  end

  defp get_social_media(data) do
    {:ok, Map.get(data, :social_media)}
  end

  defp return_state({:ok, data}, _state) do
    {:ok, data}
  end

  defp return_state(_result, state) do
    {:ok, state}
  end
end
