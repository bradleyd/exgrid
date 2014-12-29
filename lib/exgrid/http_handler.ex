defmodule ExGrid.HTTPHandler do
  @moduledoc """
  Wrapper for all HTTP calls
  """

  #def request(client, method, url \\ payload) when method == :get do
    #response = HTTPotion.get(url, set_headers)
    #{_, body} =  parse_body(response.body)
    #{ response.status_code, body }
  #end

  #def request(client, method, url \\ payload) when method == :post do
    #response = HTTPotion.post(url, payload, set_headers, [])
    #{_, body} =  parse_body(response.body)
    #{response.status_code, body}
  #end

  @doc """
  Performs GET request
  """
  def get(_, url), do: get(url)
  def get(url) do
    response = HTTPotion.get(url, set_headers)
    {_, body} =  parse_body(response.body)
    { response.status_code, body }
  end

  @doc """
  Performs POST request
  """
  def post(_, url, payload), do: post(url, payload)
  def post(url, payload) do
    response = HTTPotion.post(url, payload, set_headers, [])
    {_, body} =  parse_body(response.body)
    {response.status_code, body}
  end

  @doc """
  Build headers
  """
  def set_headers do
    HashDict.new
    |> HashDict.put(:"content-type", "application/x-www-form-urlencoded")
  end

  @doc """
  Encode the key value payload to JSON
  """
  def encode_payload(payload) do
    {:ok, json } = JSON.encode(payload)
    json
  end

  defp parse_body(body) do
    case body do
      nil -> nil
      ""  -> {:ok, body}
      body -> body |> JSON.decode 
    end
  end
end
