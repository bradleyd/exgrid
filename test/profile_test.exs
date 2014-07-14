defmodule ExGrid.ProfileTest do
  use ExUnit.Case

  test "profile has username" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.Profile.get(creds)
    assert HashDict.has_key?(Enum.at(body,0), "username")
  end

  test "set profile address" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.Profile.set(creds, %{address: "456 Main st"})
    assert { "success", _ }  == HashDict.pop(body, "message")
  end
  
  
end
 
