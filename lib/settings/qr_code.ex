defmodule Settings.QrCode do
  @moduledoc """
  Documentation for QrCode.
  """

  @positions [:left_down, :left_up, :right_down, :right_up]

  @type position :: :left_down | :left_up | :right_down | :right_up

  @type t :: %__MODULE__{
          on_client: boolean,
          on_photo: boolean,
          position: position
        }

  defstruct on_client: false,
            on_photo: false,
            position: :left_down

  @spec put_on_client(Settings.Model.t(), boolean()) :: Settings.Model.t()
  def put_on_client(model, toggled?) do
    put_in(model.qr_code.on_client, toggled?)
  end

  @spec put_on_photo(Settings.Model.t(), boolean()) :: Settings.Model.t()
  def put_on_photo(model, toggled?) do
    put_in(model.qr_code.on_photo, toggled?)
  end

  @spec put_position(Settings.Model.t(), position()) :: Settings.Model.t()
  def put_position(model, new_position)
    when new_position in @positions do
    put_in(model.qr_code.position, new_position)
  end

  @spec put_position_as_string(Settings.Model.t()) :: Settings.Model.t()
  def put_position_as_string(model) do
    put_position(model, position(model.qr_code.position))
  end

  defp position("left_down"), do: :left_down
  defp position("left_up"), do: :left_up
  defp position("right_down"), do: :right_down
  defp position("right_up"), do: :right_up
end
