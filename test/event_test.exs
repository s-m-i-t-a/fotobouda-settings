defmodule EventTest do
  use ExUnit.Case

  alias Settings.{Event, Model}

  test "should update model with event name" do
    name = "Foo Bar"
    %{name_event: name_event} =
      %Model{}
      |> Event.put_name_event(name)

    assert name_event == name
  end
end
