defmodule ExGrid.Bounces do
  alias ExGrid.HTTPHandler

  def get(credentials) do
    IO.puts build_url("bounces", "get", credentials)
    {code, body} = HTTPHandler.get(credentials, build_url("bounces", "get", credentials))
  end

  def get(credentials, optional_parameters) do
    {code, body} = HTTPHandler.get(credentials, build_url("bounces", "get", Map.merge(credentials, optional_parameters)))
  end


  defp build_form_data(creds, message) do
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

end
