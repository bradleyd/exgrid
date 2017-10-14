defmodule ExGrid.StatsTest do
  use ExUnit.Case

  defp credentials do
    ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
  end

  test "it gets all stats" do
    {:ok, creds} = credentials()
    assert {200, body} = ExGrid.Statistics.get(creds)
    assert Map.has_key?(Enum.at(body,0), "date")
  end

  test "stats filters via days parameter" do
    {:ok, creds} = credentials()
    assert {200, body} = ExGrid.Statistics.get(creds, %{days: 1})
    assert Map.has_key?(Enum.at(body,0), "date")
  end

  test "stats filters via aggregate" do
    {:ok, creds} = credentials()
    assert {200, body} = ExGrid.Statistics.get(creds, %{aggregate: 1})
    assert Map.has_key?(body, "delivered")
  end

  test "fetches all the categories" do
    {:ok, creds} = credentials()
    assert {200, body} = ExGrid.Statistics.categories(creds)
    # probably empty..better test?
    assert is_list(body) || is_map(body)
  end
end
