defmodule ExGrid.MessageTest do
  use ExUnit.Case

  test "message can be initiated from new" do
    {:ok, foo } = ExGrid.Message.new(%{to: "foobar"})
    assert foo.to == "foobar"
  end

  test "message return :error if missing attributes" do
    assert {:error, msg,%ExGrid.Message{} } = ExGrid.Message.new(%{})
  end
end
