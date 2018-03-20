defmodule Settings.Model do
  @moduledoc """
  Model structure and defaults.
  """
  require Logger


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
    media
      |> is_in_social_media?()
      |> update(model)
  end

  def media("facebook"), do: :facebook
  def media("twitter"), do: :twitter
  def media("pinterest"), do: :pinterest

  defp is_in_social_media?(media) do
    Enum.reduce_while(
      media,
      nil,
      fn
        (x, _acc) when x in @social_networks ->
          {:cont, {:ok, media}}
        (x, _acc) ->
          {:halt, {:error, "'#{x}' - invalid social network name."}}
      end
    )
  end

  defp update({:ok, media}, %__MODULE__{} = model) do
    %{model | social_media: media}
  end

  defp update({:error, msg}, %__MODULE__{} = model) do
    Logger.error(fn -> msg end)
    model
  end
end
