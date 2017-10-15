defmodule ExGrid.ProfileTest do
  use ExUnit.Case

  defp credentials do
    ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
  end

  test "get profile" do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Profile.get(creds)
  end

  test "set profile address" do
    {:ok, creds} = credentials()
    profile = %{"address" => "123 Main st"}
    assert {200, _body} = ExGrid.Profile.set(creds, %{address: Map.get(profile, "address")})
  end
end
