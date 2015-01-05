defmodule ExGrid.BouncesTest do
  use ExUnit.Case

  defp credentials do
    ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
  end

  test "bounces has a status" do
    {:ok, creds} = credentials
    assert {200, _body} = ExGrid.Bounces.get(creds)
  end

  test "bounces filters via date parameter" do
    {:ok, creds} = credentials
    assert {200, _body} = ExGrid.Bounces.get(creds, %{date: 1})
  end

  test "bounces filters via email address" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Bounces.get(creds, %{email: "thisemailshouldnotexist@nowhere.com"})
    assert Enum.count(body) == 0
  end

  # depending on your data this might be 0
  # as long as it is not greater(>) than 1
  test "bounces filters via limit parameter" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Bounces.get(creds, %{limit: 1})
    assert Enum.count(body) <= 1
  end

  test "bounces filters via multiple parameters" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Bounces.get(creds, %{limit: 1, date: 1})
    assert Enum.count(body) <= 1
  end

  test "bounces filter via type" do
    {:ok, creds} = credentials
    assert {200, _body} = ExGrid.Bounces.get(creds, %{type: "hard"})
  end

  test "gets bounces by start_date" do
    {:ok, creds} = credentials
    assert {200, _body} = ExGrid.Bounces.get(creds, %{start_date: "2013-09-10"})
  end

  test "gets bounces by start_date and end_date" do
    {:ok, creds} = credentials
    assert {200, _body} = ExGrid.Bounces.get(creds, %{start_date: "2013-09-10", end_date: "2014-07-20"})
  end

  test "bounces returns error when start_date is > end_date" do
    {:ok, creds} = credentials
    assert {:error, "Start date is older than end date"} = ExGrid.Bounces.get(creds, %{start_date: "2014-07-20", end_date: "2013-09-10"})
  end

  test "returns bounce count" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Bounces.count(creds)
    assert Dict.has_key?(body, "count")
  end

  test "remove bounce" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Bounces.remove(creds, %{type: "soft"})
    assert {"message", "success"} == Enum.at(body,0)
  end
end
