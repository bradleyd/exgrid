defmodule ExGrid.ProfileTest do
  use ExUnit.Case

  defp credentials do
    ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
  end

  test "profile has username" do
    {:ok, creds} = credentials()
    assert {200, body} = ExGrid.Profile.get(creds)
    profile = Enum.at(body, 0)
    assert Map.has_key?(profile, "username")
  end

  test "set profile address" do
    {:ok, creds} = credentials()
    assert {200, body} = ExGrid.Profile.get(creds)
    profile = Enum.at(body, 0)
    assert {200, body} = ExGrid.Profile.set(creds, %{address: Map.get(profile, "address")})
    assert Map.get(body, "message") == "success"
  end
end
