defmodule ServerTest do
  use ExUnit.Case

  alias Settings.Server

  @settings_json "settings.json"
  @modules [MySettings]

  describe "Server Settings" do
    setup do
      on_exit fn ->
        File.rm(@settings_json)
      end
    end

    test "should create init state and store modules" do
      {:ok, {modules, model}} = Server.init(@modules)

      assert modules == @modules
      assert model[MySettings.key()] == MySettings.init()
    end

    test "should get data from storage" do
      {:ok, state} = Server.init(@modules)

      {:reply, model, _state} = Server.handle_call({:get, fn(model) -> model end}, nil, state)

      assert model[MySettings.key()] == MySettings.init()
    end

    test "should update stored value and save to disk" do
      {:ok, state} = Server.init(@modules)

      {:reply, :ok, {_modules, model}} = Server.handle_call(
        {:update, fn(model) -> put_in(model, [MySettings.key()], :foo) end},
        nil,
        state
      )

      assert model[MySettings.key()] == :foo
      assert File.exists?(@settings_json)

      assert load_stored_data()[MySettings.key()] == "foo"
    end

    test "should get value, update it and save to disk" do
      {:ok, state} = Server.init(@modules)

      {:reply, old_value, {_modules, model}} = Server.handle_call(
        {:get_and_update, fn(model) -> {model[MySettings.key()], put_in(model, [MySettings.key()], :foo)} end},
        nil,
        state
      )

      assert old_value == MySettings.init()
      assert model[MySettings.key()] == :foo
      assert File.exists?(@settings_json)

      assert load_stored_data()[MySettings.key()] == "foo"
    end

    test "should load data from settings.json if this file exists" do
      {:ok, state} = Server.init(@modules)
      {:reply, :ok, _state} = Server.handle_call(
        {:update, fn(model) -> put_in(model, [MySettings.key()], :foo) end},
        nil,
        state
      )

      assert File.exists?(@settings_json)

      {:ok, {_modules, model}} = Server.init(@modules)

      assert model[MySettings.key()] == :foo
    end

    test "should append module in runtime" do
      {:reply, :ok, {modules, model}} = Server.handle_call({:register, MySettings}, nil, {[], %{}})

      assert modules == @modules
      assert model[MySettings.key()] == MySettings.init()

      assert File.exists?(@settings_json)
      assert load_stored_data()[MySettings.key()] == to_string(MySettings.init())
    end
  end

  defp load_stored_data() do
    @settings_json
    |> File.read!()
    |> Poison.decode!()
  end
end

