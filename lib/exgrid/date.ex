defmodule ExGrid.Date do
  use Timex

  @moduledoc """
  Utility functions used by API client modules
  """

  @doc """
  Parses a date string to a datetime struct.
  Uses YYYY-M-D format by default.
  """
  def parse_date(date, format \\ "{YYYY}-{M}-{D}") do
    {:ok, _sdate} = Timex.parse(date, format)
  end

  @doc """
  Compare two dates returning one of the following values:
   * `-1` -- the first date comes before the second one
   * `0`  -- both arguments represent the same date when coalesced to the same timezone.
   * `1`  -- the first date comes after the second one
  """
  def compare_dates(%DateTime{} = first_date, %DateTime{} = second_date) do
    Timex.compare(first_date, second_date)
  end
  def compare_dates(first_date, second_date, format \\ "{YYYY}-{M}-{D}") do
    {:ok, first_date}  = Timex.parse(first_date, format)
    {:ok, second_date} = Timex.parse(second_date, format)
    Timex.compare(first_date, second_date)
  end
end
