defmodule ExGrid.BlocksTest do
  use ExUnit.Case

  # TODO build better integration tests for blocks

  defp credentials do
    ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
  end

  test "blocks has a status" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.get(creds)
    # could be empty list
    assert (is_list(body) || is_map(body))
  end

  test "blocks filters via date parameter" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.get(creds, %{date: 1})
    assert (is_list(body) || is_map(body))
  end

  test "blocks filters via email address" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.get(creds, %{email: "thisemailshouldnotexist@nowhere.com"})
    assert Enum.count(body) == 0
  end

  # depending on your data this might be 0
  # as long as it is not greater(>) than 1
  test "blocks filters via limit parameter" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.get(creds, %{limit: 1})
    assert Enum.count(body) <= 1
  end

  test "blocks filters via multiple parameters" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.get(creds, %{limit: 1, date: 1})
    assert Enum.count(body) <= 1
  end

  test "blocks filter via type" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.get(creds, %{type: "hard"})
    assert (is_list(body) || is_map(body))
  end

  test "gets blocks by start_date" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.get(creds, %{start_date: "2013-09-10"})
    assert (is_list(body) || is_map(body))
  end

  test "gets blocks by start_date and end_date" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.get(creds, %{start_date: "2013-09-10", end_date: "2014-07-20"})
    assert (is_list(body) || is_map(body))
  end

  test "blocks returns error when start_date is > end_date" do
    assert {:ok, creds} = credentials
    assert {:error, "Start date is older than end date"} = ExGrid.Blocks.get(creds, %{start_date: "2014-07-20", end_date: "2013-09-10"})
  end

  test "returns block count" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.count(creds)
    assert Dict.has_key?(body, "count")
  end

  test "remove block" do
    {:ok, creds} = credentials
    assert {200, body} = ExGrid.Blocks.remove(creds, %{email: "foo@bar.com"})
    assert {"message", "Email does not exist"} == Enum.at(body,0)
  end
end
