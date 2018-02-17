defmodule Settings.Model do
  @moduledoc """
  Model structure and defaults.
  """


  @social_networks [:facebook, :twitter, :pinterest]

  @type social_networks :: :facebook | :twitter | :pinterest

  @type t :: %__MODULE__{
    name_event: String.t,
    social_media: list social_networks
  }

  defstruct [
    name_event: "",
    social_media: []
  ]

  def create() do
    %__MODULE__{}
  end

  def put_name_event(%__MODULE__{} = model, name) do
    %{model | name_event: name}
  end

  def put_social_media(%__MODULE__{} = model, media) do
    case is_in_social_media?(media) do
      true -> %{model | social_media: media}
      _ -> model
    end
  end

  defp is_in_social_media?(media) do
    Enum.reduce(media, true, fn(x, acc) ->
      x in @social_networks and acc
    end)
  end

end
