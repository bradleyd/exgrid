defmodule ExGrid.API do
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