defmodule Settings.Camera do
  @moduledoc """
  A camera settings
  """

  @behaviour Settings.Behaviour

  @type camera_type :: :wifi_sony_hx60 | :usb_nikon

  @cameras [:wifi_sony_hx60, :usb_nikon]


  @impl true
  def key() do
    Atom.to_string(__MODULE__)
  end

  @impl true
  def init() do
    :wifi_sony_hx60
  end

  @impl true
  def decoder(model) do
  end

  # def put_camera(%__MODULE__{} = model, camera_type) when camera_type in @cameras do
  #   %{model | camera: camera_type}
  # end

  # def put_camera_as_string(%__MODULE__{} = model) do
  #   put_camera(model, camera(model.camera))
  # end

  # defp camera("wifi_sony_hx60"), do: :wifi_sony_hx60
  # defp camera("usb_nikon"), do: :usb_nikon
end
