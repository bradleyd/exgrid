defmodule ExGrid.BouncesTest do
  use ExUnit.Case

  test "bounces has a status" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.Bounces.get(creds)
    IO.inspect body
    assert HashDict.has_key?(Enum.at(body,0), "status")
  end

  test "bounces retrieves in the past" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.Bounces.get(creds, %{days: 1})
    IO.inspect body
    #assert HashDict.has_key?(Enum.at(body,0), "status")
  end

  #test "remove bounce" do
    #{ :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    #{200, body} = ExGrid.Bounces.remove(creds, %{address: "456 Main st"})
    #assert { "success", _ }  == HashDict.pop(body, "message")
  #end
  
  
end
 
