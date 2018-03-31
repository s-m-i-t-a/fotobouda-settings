defmodule Settings.Model do
  @moduledoc """
  Model structure and defaults.
  """
  require Logger


  @social_networks [:facebook, :twitter, :pinterest]
  @media_list Enum.map(@social_networks, &Atom.to_string/1)

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
    |> media_to_atom()
    |> update(model)
  end

  defp is_in_social_media?(media) do
    Enum.reduce_while(
      media,
      nil,
      fn
        (x, _acc) when x in @media_list ->
          {:cont, {:ok, media}}
        (x, _acc) ->
          {:halt, {:error, "'#{x}' - invalid social network name."}}
      end
    )
  end

  def media_to_atom({:ok, media}) do
    {:ok, Enum.map(media, &media/1)}
  end

  def media_to_atom(err) do
    err
  end

  defp media("facebook"), do: :facebook
  defp media("twitter"), do: :twitter
  defp media("pinterest"), do: :pinterest

  defp update({:ok, media}, %__MODULE__{} = model) do
    %{model | social_media: media}
  end

  defp update({:error, msg}, %__MODULE__{} = model) do
    Logger.error(fn -> msg end)
    model
  end
end
