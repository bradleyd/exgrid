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
    response = HTTPotion.get(url, options())
    {_, body} =  parse_body(response.body)
    { response.status_code, body }
  end

  @doc """
  Performs POST request
  """
  def post(_, url, payload), do: post(url, payload)
  def post(url, payload) do
    response = HTTPotion.post(url, options(payload))
    {_, body} =  parse_body(response.body)
    {response.status_code, body}
  end

  @doc """
  Build headers
  """
  def headers do
    ["Content-Type": "application/x-www-form-urlencoded"]
  end

  @doc """
  Build options list for HTTP
  """
  def options do
     [headers: headers(), ibrowse: [max_pipeline_size: 15, max_sessions: 15]]
  end
  def options(payload) do
    [body: payload, headers: headers(), ibrowse: [max_pipeline_size: 15, max_sessions: 15]]
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
