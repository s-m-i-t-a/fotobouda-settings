defmodule Settings.Persistence do
  @moduledoc """
  Saving and loading data from json file.
  """

  alias Settings.Model

  @settings_json "settings.json"

  def to_json_file(data) do
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
    # Poison.decode(data, as: %Model{})
    Poison.decode(data)
  end

  defp decode_data(err) do
    err
  end

  defp update_social_media_to_atom({:ok, data}) do
    update_model =
      data.social_media
      |> update_in(fn(media) -> {:ok, media} |> Model.media_to_atom() |> elem(1) end)

    {:ok, update_model}
  end

  defp update_social_media_to_atom(err) do
    err
  end

  defp return_state({:ok, data}, _state) do
    {:ok, data}
  end

  defp return_state(_result, state) do
    {:ok, state}
  end
end
