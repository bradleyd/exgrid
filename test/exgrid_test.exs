defmodule ExGridTest do
  use ExUnit.Case

  test "returns error if api_user is missing" do
    IO.inspect ExGrid.credentials(%{api_key: 'foo'})
    assert {:error } = ExGrid.credentials(%{api_key: 'foo'})
  end

  test "returns error if api_key is missing" do
    IO.inspect ExGrid.credentials(%{api_user: 'foo'})
    assert { :error } = ExGrid.credentials(%{api_user: 'foo'})
  end

  test "returns ExGrid.credentials{}" do
    IO.inspect ExGrid.credentials(%{api_user: 'foo', api_user: 'me'})
    assert %ExGrid{api_user: 'foo', api_user: 'me'} = ExGrid.credentials(%{api_user: 'foo', api_user: 'me'})
  end

end
