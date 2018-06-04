defmodule ModelTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias Settings.{Model, QrCode}

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
    %{camera: camera} =
      %Model{camera: "usb_nikon"}
      |> Model.put_camera_as_string()

    assert camera == :usb_nikon
  end

  test "should update model with Qr code on client" do
    on_client = true
    %{qr_code: qr_code} =
      %Model{}
      |> QrCode.put_on_client(on_client)

    assert qr_code.on_client == on_client
  end

  test "should update model with Qr code on photo" do
    on_photo = true
    %{qr_code: qr_code} =
      %Model{}
      |> QrCode.put_on_photo(on_photo)

    assert qr_code.on_photo == on_photo
  end

  test "should update model with Qr code position" do
    %{qr_code: qr_code} =
      %Model{qr_code: %QrCode{position: "right_up"}}
      |> QrCode.put_position_as_string()

    assert qr_code.position == :right_up
  end
end

