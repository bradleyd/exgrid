defmodule ExGrid.Util do
  use Timex

  @moduledoc """
  Utility functions used by API client modules
  """

  @doc """
  Parses a date string to a datetime struct.
  Uses YYYY-M-D format by default.
  """
  def parse_date(date, format \\ "{YYYY}-{M}-{D}") do
    {:ok, _sdate} = DateFormat.parse(date, format)
  end

  @doc """
  Compare two dates returning one of the following values:
   * `-1` -- the first date comes before the second one
   * `0`  -- both arguments represent the same date when coalesced to the same timezone.
   * `1`  -- the first date comes after the second one
  """
  def compare_dates(%DateTime{} = first_date, %DateTime{} = second_date) do
    Date.compare(first_date, second_date)
  end
  def compare_dates(first_date, second_date, format \\ "{YYYY}-{M}-{D}") do
    {:ok, first_date} = DateFormat.parse(first_date, format)
    {:ok, second_date} = DateFormat.parse(second_date, format)
    Date.compare(first_date, second_date)
  end

  @doc """
  Build API endpoint URL
  """
  def build_url(context, verb) do
    "https://api.sendgrid.com/api/" <> context <> "." <> verb <> ".json?"
  end
  def build_url(context, verb, query_params) do
    "https://api.sendgrid.com/api/" <> context <> "." <> verb <> ".json?" <> build_form_data(query_params)
  end

  @doc """
  Build Form data for GET or POST
  """
  def build_form_data(creds) do
    Enum.map(Map.to_list(creds), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end
  def build_form_data(creds, message) do
    full_message = Map.merge(creds, message)
    Enum.map(Map.to_list(full_message), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end
end