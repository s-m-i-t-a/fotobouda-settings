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

  def put_on_client(model, is_toggled?) do
    updated_qr_code =
      model
      |> update_qr_code(:on_client, is_toggled?)

    %{model | qr_code: updated_qr_code}
  end

  def put_on_photo(model, is_toggled?) do
    updated_qr_code =
      model
      |> update_qr_code(:on_photo, is_toggled?)

    %{model | qr_code: updated_qr_code}
  end

  def put_position(model, new_position)
    when new_position in @positions do
    updated_qr_code =
      model
      |> update_qr_code(:position, new_position)

    %{model | qr_code: updated_qr_code}
  end

  def put_position_as_string(model) do
    pos =
      model
      |> Map.get(:qr_code)
      |> Map.get(:position)

    put_position(model, position(pos))
  end

  defp position("left_down"), do: :left_down
  defp position("left_up"), do: :left_up
  defp position("right_down"), do: :right_down
  defp position("right_up"), do: :right_up

  defp update_qr_code(model, key, value) do
    {_, update_model} =
      model
      |> Map.get(:qr_code)
      |> Map.get_and_update(key, &{&1, value})

    update_model
  end
end
