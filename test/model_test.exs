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

  test "should update model with camera type" do
    %{camera: camera} =
      %Model{camera: "usb_nikon"}
      |> Model.put_camera_as_string()

    assert camera == :usb_nikon
  end
end

