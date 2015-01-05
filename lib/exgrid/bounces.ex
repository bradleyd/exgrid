defmodule ExGrid.Bounces do
  import ExGrid.Date
  import ExGrid.API
  alias ExGrid.HTTPHandler

  @moduledoc """
  Manage bounces
  """

  @doc """
  get all bounces
  """
  def get(credentials) do
    {_code, _body} = HTTPHandler.get(credentials, build_url("bounces", "get", credentials))
  end

  @doc """
  get bounces with optional parameters
  
  * see [sendgrid api docs](https://sendgrid.com/docs/API_Reference/Web_API/bounces.html)

  * note for `start_date` and `end_date` they must be in `YYYY-M-D` string format

  ### Examples:

  iex> ExGrid.Bounces.get(credentials, %{start_date: "2014-7-10", end_date: "2014-7-20"})\r\n
  iex> ExGrid.Bounces.get(credentials, %{date: "1"})\r\n
  iex> ExGrid.Bounces.get(credentials, %{date: 1, limit: 1})\r\n
  
  """
  def get(credentials, %{start_date: start_date, end_date: end_date}) do
    {:ok, sdate} = parse_date(start_date)
    {:ok, edate} = parse_date(end_date)
    result = compare_dates(sdate, edate)
    case result do
      -1 ->
        {_code, _body} = HTTPHandler.get(credentials, build_url("bounces", "get", credentials, %{start_date: start_date, end_date: end_date}))
      0 ->
        {:error, "Dates are the same"}
      1 ->
        {:error, "Start date is older than end date"}   
    end   
  end

  def get(credentials, %{start_date: _start_date}=sdate) do
    cond do
      {:ok, _start_date} = parse_date(sdate.start_date) ->
        {_code, _body} = HTTPHandler.get(credentials, build_url("bounces", "get", credentials, sdate))
      {:error, _start_date} =  parse_date(sdate.start_date) ->
        {:error, "Start date is older than end date"}   
    end 
  end

  def get(credentials, optional_parameters) when is_map(optional_parameters) do
    {_code, _body} = HTTPHandler.get(credentials, build_url("bounces", "get", credentials, optional_parameters))
  end

  @doc """
  get bounce count
  """
  def count(credentials) do
    {_code, _body} = HTTPHandler.get(credentials, build_url("bounces", "count", credentials))
  end

  @doc """
  Remove a bounce

  ### Examples

  iex> ExGrid.Bounces.remove(credentials, %{email: "foobar@baz.com"})

  iex> ExGrid.Bounces.remove(credentials, %{type: "soft"})
  """
  def remove(credentials, optional_parameters) when is_map(optional_parameters) do
    {_code, _body} = HTTPHandler.post(credentials, build_url("bounces", "delete"), build_form_data(credentials, optional_parameters))
  end
end
