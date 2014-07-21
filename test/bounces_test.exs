defmodule ExGrid.BouncesTest do
  use ExUnit.Case

  test "bounces has a status" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.Bounces.get(creds)
    IO.inspect body
    assert HashDict.has_key?(Enum.at(body,0), "status")
  end

  test "bounces accepts date parameter" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.Bounces.get(creds, %{date: 1})
    assert HashDict.has_key?(Enum.at(body,0), "created")
  end

  test "gets bounces by type" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.Bounces.get(creds, %{type: "hard"})
    assert HashDict.has_key?(Enum.at(body,0), "status")
  end

  test "gets bounces by start_date" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.Bounces.get(creds, %{start_date: "2013-09-10"})
    IO.inspect body
    assert HashDict.has_key?(Enum.at(body,0), "status")
  end


  test "gets bounces by start_date and end_date" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    {200, body} = ExGrid.Bounces.get(creds, %{start_date: "2013-09-10", end_date: "2014-07-20"})
    IO.inspect body
    assert HashDict.has_key?(Enum.at(body,0), "status")
  end

  test "bounces returns error when start_date is > end_date" do
    { :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    assert {:error, "Start date is older than end date"} = ExGrid.Bounces.get(creds, %{start_date: "2014-07-20", end_date: "2013-09-10"})
  end

  #test "remove bounce" do
    #{ :ok, creds } = ExGrid.credentials(%{api_key: System.get_env("API_KEY"), api_user: System.get_env("API_USER")})
    #{200, body} = ExGrid.Bounces.remove(creds, %{address: "456 Main st"})
    #assert { "success", _ }  == HashDict.pop(body, "message")
  #end
  
  
end
 
