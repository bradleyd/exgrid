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
  Compares two datetime structs.

  Returns:

  `1` == start date is before end date
  `0` == dates are the same
  `-1` == start date is 
  """
  def compare_dates(first_date, second_date) do
    Date.compare(first_date, second_date)
  end

end