defmodule Settings.Model do
  @moduledoc """
  Model structure and defaults.
  """
  require Logger

  alias Settings.QrCode


  @cameras [:wifi_sony_hx60, :usb_nikon]
  @social_networks [:facebook, :twitter, :pinterest]
  @media_list Enum.map(@social_networks, &Atom.to_string/1)

  @type camera_type :: :wifi_sony_hx60 | :usb_nikon
  @type social_networks :: :facebook | :twitter | :pinterest


  @type t :: %__MODULE__{
    name_event: String.t,
    social_media: (list social_networks),
    camera: camera_type,
    qr_code: QrCode.t(),
  }

  defstruct [
    name_event: "",
    social_media: [],
    camera: :wifi_sony_hx60,
    qr_code: %QrCode{},
  ]

  def create() do
    %__MODULE__{}
  end

  def put_name_event(%__MODULE__{} = model, name) do
    %{model | name_event: name}
  end

  def put_social_media(%__MODULE__{} = model, media) when media == [] do
    {:ok, media}
    |> update_social_media(model)
  end

  def put_social_media(%__MODULE__{} = model, media) do
    media
    |> is_in_social_media?()
    |> media_to_atom()
    |> update_social_media(model)
  end

  def put_camera(%__MODULE__{} = model, camera_type) when camera_type in @cameras do
    %{model | camera: camera_type}
  end

  def put_camera_as_string(%__MODULE__{} = model) do
    camera_type =
      model
      |> Map.get(:camera)

    put_camera(model, camera(camera_type))
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

  defp update_social_media({:ok, media}, %__MODULE__{} = model) do
    %{model | social_media: media}
  end

  defp update_social_media({:error, msg}, %__MODULE__{} = model) do
    Logger.error(fn -> msg end)
    model
  end

  defp media("facebook"), do: :facebook
  defp media("twitter"), do: :twitter
  defp media("pinterest"), do: :pinterest
  defp camera("wifi_sony_hx60"), do: :wifi_sony_hx60
  defp camera("usb_nikon"), do: :usb_nikon
end

defimpl Poison.Decoder, for: Settings.Model do
  alias Settings.{Model, QrCode}

  def decode(value, _options) do
    value
    |> Model.put_camera_as_string()
    |> QrCode.put_position_as_string()
  end
end

