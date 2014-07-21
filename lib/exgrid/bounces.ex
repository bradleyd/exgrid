defmodule ExGrid.Bounces do
  use Timex
  alias ExGrid.HTTPHandler

  @doc """
  get bounces
  """
  def get(credentials) do
    {code, body} = HTTPHandler.get(credentials, build_url("bounces", "get", credentials))
  end

  @doc """
  get bounces between start and end date

  `1` == start date is before end date

  `0` == dates are the same

  `-1` == start date is 

  Example:\r\n
  iex> ExGrid.Bounces.get(credentials, %{start_date: "2014-7-10", end_date: "2014-7-20"})\r\n
  """
  def get(credentials, %{start_date: start_date, end_date: end_date}) do
    {:ok, sdate, _} = DateFormat.parse(start_date,"{YYYY}-{M}-{D}")
    {:ok, edate, _} = DateFormat.parse(end_date,"{YYYY}-{M}-{D}")
    cond do
      1 == Date.compare(sdate, edate) ->
        {code, body} = HTTPHandler.get(credentials, build_url("bounces", "get", Map.merge(credentials, %{start_date: start_date, end_date: end_date})))
      0 == Date.compare(sdate, edate) ->
        {:error, "Dates are the same"}
      -1 == Date.compare(sdate, edate) ->
        {:error, "Start date is older than end date"}   
    end   
  end

  def get(credentials, %{start_date: start_date}) do
    cond do
      {:ok, sdate, _} = DateFormat.parse(start_date,"{YYYY}-{M}-{D}") ->
        {code, body} = HTTPHandler.get(credentials, build_url("bounces", "get", Map.merge(credentials, %{start_date: start_date})))
      {:error, sdate, "" } ==  DateFormat.parse(start_date,"{YYYY}-{M}-{D}") ->
        {:error, "Start date is older than end date"}   
    end 
  end

  def get(credentials, optional_parameters) do
    {code, body} = HTTPHandler.get(credentials, build_url("bounces", "get", Map.merge(credentials, optional_parameters)))
  end



  defp build_form_data(creds) do
    Enum.map(Map.to_list(creds), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end

  defp build_form_data(creds, message) do
    full_message = Map.merge(creds, message)
    Enum.map(Map.to_list(full_message), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end

  defp build_url(context, verb) do
    "https://api.sendgrid.com/api/" <> context <> "." <> verb <> ".json?"
  end

  defp build_url(context, verb, query_params) do
    "https://api.sendgrid.com/api/" <> context <> "." <> verb <> ".json?" <> build_form_data(query_params)
  end

  defp check_time(time1, time2) when is_bitstring(time1) do

  end
end
