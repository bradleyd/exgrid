defmodule ExGrid.InvalidEmailsTest do
  use ExUnit.Case

  test "invalid_emails has a status" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.InvalidEmails.get(creds)
    assert HashDict.has_key?(Enum.at(body,0), "reason")
  end

  test "invalid_emails filters via date parameter" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.InvalidEmails.get(creds, %{date: 1})
    assert HashDict.has_key?(Enum.at(body,0), "created")
  end

  test "invalid_emails filters via email address" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.InvalidEmails.get(creds, %{email: "thisemailshouldnotexist@nowhere.com"})
    assert Enum.count(body) == 0
  end


  # depending on your data this might be 0
  # as long as it is not greater(>) than 1
  test "invalid_emails filters via limit parameter" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.InvalidEmails.get(creds, %{limit: 1})
    assert Enum.count(body) <= 1
  end

  test "invalid_emails filters via multiple parameters" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.InvalidEmails.get(creds, %{limit: 1, date: 400})
    assert (is_list(body) || is_map(body))
    #assert Enum.count(body) <= 1
    #assert HashDict.has_key?(Enum.at(body,0), "created")
  end

  test "gets invalid_emails by start_date" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.InvalidEmails.get(creds, %{start_date: "2013-09-10"})
    assert HashDict.has_key?(Enum.at(body,0), "status")
  end

  test "gets invalid_emails by start_date and end_date" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.InvalidEmails.get(creds, %{start_date: "2013-09-10", end_date: "2014-07-20"})
    assert HashDict.has_key?(Enum.at(body,0), "status")
  end

  test "invalid_emails returns error when start_date is > end_date" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    assert {:error, "Start date is older than end date"} = ExGrid.InvalidEmails.get(creds, %{start_date: "2014-07-20", end_date: "2013-09-10"})
  end

  test "returns invalid_email count" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.InvalidEmails.count(creds)
    assert HashDict.has_key?(body, "count")
  end

  test "remove invalid_email" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.InvalidEmails.remove(creds, %{email: "thisemailshouldnotexist@nowhereland.com"})
    assert  {"message", "Email does not exist"} == Enum.at(body,0)
  end
  
  
end
