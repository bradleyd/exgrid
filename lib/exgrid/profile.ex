defmodule ExGrid.Profile do

  alias ExGrid.HTTPHandler


  def get(credentials) do
    {code, body} = HTTPHandler.get(credentials, build_url("profile", "get", credentials))
  end

  def set(credentials, profile_attributes) do
    {code, body} = HTTPHandler.post(credentials, build_url("profile", "set"), build_form_data(credentials, profile_attributes))
  end

  defp build_form_data(creds, message) do
    IO.inspect creds
    IO.inspect message
    full_message = Map.merge(creds, message)
    Enum.map(Map.to_list(full_message), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end

  defp build_form_data(creds) do
    Enum.map(Map.to_list(creds), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end

  defp build_url(context, verb) do
    "https://api.sendgrid.com/api/" <> context <> "." <> verb <> ".json?"
  end

  defp build_url(context, verb, query_params) do
    "https://api.sendgrid.com/api/" <> context <> "." <> verb <> ".json?" <> build_form_data(query_params)
  end


  defp build_query_params(creds) do
    Enum.map(Map.to_list(creds), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end



end

