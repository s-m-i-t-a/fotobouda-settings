defmodule QrCodeTest do
  use ExUnit.Case

  alias Settings.{Model, QrCode}


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
