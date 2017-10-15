defmodule ExGrid.Statistics do
  import ExGrid.Date
  import ExGrid.API

  @http_handler Application.get_env(:exgrid, :http_handler)

  @moduledoc """
  Fetch statistics
  """

  @doc """
  get all stats
  """
  def get(credentials) do
    {_code, _body} = @http_handler.post(credentials, build_url("stats", "get"), build_form_data(credentials))
  end
  
  @doc """
  get all categories
  """
  def categories(credentials) do
    {_code, _body} = @http_handler.post(credentials, build_url("stats", "get"), build_form_data(credentials, %{list: true}))
  end


  @doc """
  get stats with optional parameters
  
  * see [sendgrid api docs](https://sendgrid.com/docs/API_Reference/Web_API/stats.html)

  * note for `start_date` and `end_date` they must be in `YYYY-M-D` string format

  ### Examples:

  iex> ExGrid.Statistics.get(credentials, %{start_date: "2014-7-10", end_date: "2014-7-20"})\r\n
  iex> ExGrid.Statistics.get(credentials, %{days: "1"})\r\n
  iex> ExGrid.Statistics.get(credentials, %{aggregate: 1, days: 1})\r\n
  
  """
  def get(credentials, %{start_date: start_date, end_date: end_date}) do
    {:ok, sdate} = parse_date(start_date)
    {:ok, edate} = parse_date(end_date)
    result = compare_dates(sdate, edate)
    case result do
      -1 ->
        {_code, _body} = @http_handler.post(credentials, build_url("stats", "get"), build_form_data(credentials, %{start_date: start_date, end_date: end_date}))
      0 ->
        {:error, "Dates are the same"}
      1 ->
        {:error, "Start date is older than end date"}   
    end   
  end

  def get(credentials, %{start_date: _start_date}=sdate) do
    cond do
      {:ok, _start_date} = parse_date(sdate.start_date) ->
        {_code, _body} = @http_handler.post(credentials, build_url("stats", "get"), build_form_data(credentials, sdate))
      {:error, _start_date} =  parse_date(sdate.start_date) ->
        {:error, "Start date is older than end date"}   
    end 
  end

  def get(credentials, optional_parameters) when is_map(optional_parameters) do
    {_code, _body} = @http_handler.post(credentials, build_url("stats", "get"), build_form_data(credentials, optional_parameters))
  end
end
