defmodule ExGrid.MessageTest do
  use ExUnit.Case

  test "message will :error if missing all the defaults" do
    assert_raise KeyError, fn -> 
      ExGrid.Message.new([to: "foobar"])
    end
  end

  test "message return :error if empty Map" do
    assert {:error, _ } = ExGrid.Message.new([])
  end

  test "message return ok when built with minimum defaults" do
    { :ok, msg } = ExGrid.Message.new([to: "foo", from: "me@myself.com", subject: "hello", text: "how are you?"])
    assert msg.to == "foo"
    assert msg.from == "me@myself.com"
  end
  
end
