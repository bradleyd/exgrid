defmodule ExGrid.MessageTest do
  use ExUnit.Case

  test "message will :error if missing all the defaults" do
    {:error, _ } = ExGrid.Message.new(%{to: "foobar"})
  end

  test "message return :error if empty Map" do
    assert {:error, _ } = ExGrid.Message.new(%{})
  end

  test "message return ok when built with minimum defaults" do
    { :ok, msg } = ExGrid.Message.new(%{to: "foo", from: "me@mmyself.com", subject: "hello", text: "how are you?"})    
  end
  
end
