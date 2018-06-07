defmodule Settings.Model do
  @moduledoc """
  Model structure and defaults.
  """
  require Logger

  alias Settings.{Camera, Event, QrCode, SocialMedia}

  @settings [Camera, Event, QrCode, SocialMedia]

  def create() do
    Enum.reduce(@settings, %{}, fn(module, acc) -> Map.put_new(acc, module.key(), module.init()) end)
  end
end

defimpl Poison.Decoder, for: Settings.Model do
  alias Settings.{Camera, QrCode}

  def decode(value, _options) do
    # value
    # |> Camera.put_camera_as_string()
    # |> QrCode.put_position_as_string()
  end
end
