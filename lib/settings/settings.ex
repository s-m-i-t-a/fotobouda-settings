defmodule Settings.Settings do
  @moduledoc """
  Setting structure and defaults.
  """

  @control_by [:current, :flow]

  @type control_by :: :current | :flow

  @type t :: %__MODULE__{
    active_size_of_surface: pos_integer,  # mm^2
    number_of_fc: pos_integer,
    h_2: float,  # l/min
    o_2: float,  # l/min
    min_current: float,  # A
    control_by: control_by,  # :flow or :current
  }

  defstruct [
    active_size_of_surface: 50,  # mm^2
    number_of_fc: 1,
    h_2: 0.5,  # l/min
    o_2: 0.3,  # l/min
    min_current: 1.2,  # A
    control_by: :flow,  # :flow or :current
  ]

  def create() do
    %__MODULE__{}
  end

  def put_active_size_surface(%__MODULE__{} = settings, size) do
    %{settings | active_size_of_surface: size}
  end

  def put_number_of_fc(%__MODULE__{} = settings, count) when count >= 1 do
    %{settings | number_of_fc: count}
  end

  def put_h_2(%__MODULE__{} = settings, h_2), do: %{settings | h_2: h_2}
  def put_o_2(%__MODULE__{} = settings, o_2), do: %{settings | o_2: o_2}
  def put_current(%__MODULE__{} = settings, current), do: %{settings | current: current}
  def put_control(%__MODULE__{} = settings, control) when control in @control_by do
    %{settings | control_by: control}
  end

end
