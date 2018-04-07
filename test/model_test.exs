defmodule ModelTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias Settings.Model

  test "should not update model with invalid social network" do

    assert capture_log(fn ->
      model =
        %Model{}
        |> Model.put_social_media(["foo"])

      assert model == %Model{}
    end) =~ "invalid social network name."
  end

  test "should update model with social network" do
    media = ["facebook", "twitter"]
    %{social_media: social_media} =
      %Model{}
      |> Model.put_social_media(media)

    assert social_media == [:facebook, :twitter]
  end

  test "should update model with no social network" do
    media = []
    %{social_media: social_media} =
      %Model{}
      |> Model.put_social_media(media)

    assert social_media == []
  end

  test "should update model with event name" do
    name = "Foo Bar"
    %{name_event: name_event} =
      %Model{}
      |> Model.put_name_event(name)

    assert name_event == name
  end

  test "should update model with camera type" do
    camera_type = "usb_nikon"
    %{camera: camera} =
      %Model{}
      |> Model.put_camera_as_string(camera_type)

    assert camera == :usb_nikon
  end
end

