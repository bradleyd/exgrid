defmodule ExGrid.Test.HTTPHandler do
  @moduledoc """
  Wrapper for all Mock HTTP calls
  """

  @doc """
  Performs Mock GET request
  """
  def get(_, url), do: get(url)
  def get(_url) do
    { 200, %{}}
  end

  @doc """
  Performs POST request
  """
  def post(_, url, payload), do: post(url, payload)
  def post(url, _payload) do
    { 200, %{}}
  end

end
