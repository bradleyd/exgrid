defmodule ExGridTest do
  use ExUnit.Case

  test "returns error if api_user is missing" do
    assert {:error} = ExGrid.credentials(%{api_key: 'foo'})
  end

  test "returns error if api_key is missing" do
    assert {:error} = ExGrid.credentials(%{api_user: 'foo'})
  end

  test "returns ExGrid.credentials{}" do
    assert {:ok, %ExGrid{api_key: 'foo', api_user: 'me'} } = ExGrid.credentials(%{api_key: 'foo', api_user: 'me'})
  end
end
