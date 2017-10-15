defmodule ExGrid.BouncesTest do
  use ExUnit.Case

  setup do
    now = Timex.now
    start_date = Timex.format!(now, "{YYYY}-{M}-{D}")
    end_date   = Timex.shift(now, days: 1) |> Timex.format!("{YYYY}-{M}-{D}")

    {:ok, start_date: start_date, end_date: end_date}
  end

  defp credentials do
    ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
  end

  test "bounces has a status" do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.get(creds)
  end

  test "bounces filters via date parameter" do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.get(creds, %{date: 1})
  end

  test "bounces filters via email address" do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.get(creds, %{email: "thisemailshouldnotexist@nowhere.com"})
  end

  # depending on your data this might be 0
  # as long as it is not greater(>) than 1
  test "bounces filters via limit parameter" do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.get(creds, %{limit: 1})
  end

  test "bounces filters via multiple parameters" do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.get(creds, %{limit: 1, date: 1})
  end

  test "bounces filter via type" do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.get(creds, %{type: "hard"})
  end

  test "gets bounces by start_date", state do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.get(creds, %{start_date: state[:start_date]})
  end

  test "gets bounces by start_date and end_date", state do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.get(creds, %{start_date: state[:start_date], end_date: state[:end_date]})
  end

  test "bounces returns error when start_date is > end_date", state do
    {:ok, creds} = credentials()
    assert {:error, "Start date is older than end date"} = ExGrid.Bounces.get(creds, %{start_date: state[:end_date], end_date: state[:start_date]})
  end

  test "bounce count" do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.count(creds)
  end

  test "remove a soft bounce" do
    {:ok, creds} = credentials()
    assert {200, _body} = ExGrid.Bounces.remove(creds, %{type: "soft"})
  end
end
