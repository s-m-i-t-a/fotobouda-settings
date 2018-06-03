defmodule Settings.QrCode do
  @moduledoc """
  Documentation for QrCode.
  """

  @type position :: :left_down | :left_up | :right_down | :right_up

  @type t :: %__MODULE__{
          on_client: boolean,
          on_photo: boolean,
          position: position
        }

  defstruct on_client: false,
            on_photo: false,
            position: :left_down
end
