defmodule ServerTest do
  use ExUnit.Case

  alias Settings.{Model, Server}

  @settings_json "settings.json"
  @name_event "foo"
  @media [:facebook, :twitter]
  @state %Model{name_event: @name_event, social_media: @media}

  describe "Server Settings" do
    setup do
      on_exit fn ->
        File.rm(@settings_json)
      end
    end

    test "should save data to settings.json"do
      {:noreply, new_state} = Server.handle_cast({:set, @state}, nil)
      {:ok, init} = Server.init(@state)

      assert new_state == init
      assert File.exists?(@settings_json)
    end

    test "should load data from settings.json if this file exists" do
      Server.handle_cast({:set, @state}, nil)
      {:ok, init} = Server.init(@state)

      assert init == @state
      assert File.exists?(@settings_json)
    end
  end
end

