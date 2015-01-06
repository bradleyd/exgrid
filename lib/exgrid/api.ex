defmodule ExGrid.API do
  @doc """
  Build API endpoint URL
  """
  def build_url(context, verb) do
    "https://api.sendgrid.com/api/" <> context <> "." <> verb <> ".json"
  end
  def build_url(context, verb, credentials) do
    build_url(context, verb) <> "?" <> build_form_data(credentials)
  end
  def build_url(context, verb, credentials, params) do
    build_url(context, verb) <> "?" <> build_form_data(credentials, params)
  end

  @doc """
  Build Form data for GET or POST
  """
  def build_form_data(%ExGrid{} = creds, %{__struct__: _} = params) do
    build_form_data(Map.from_struct(creds), Map.from_struct(params))
  end
  def build_form_data(%ExGrid{} = creds, params) do
    build_form_data(Map.from_struct(creds), params)
  end
  def build_form_data(%ExGrid{} = creds) do
    build_form_data(Map.from_struct(creds))
  end
  def build_form_data(creds, params) do
    build_form_data Map.merge(creds, params)
  end
  def build_form_data(args) do
    Enum.map(Map.to_list(args), fn {k,v} -> encode_attribute(k, v) end)
    |> Enum.join("&")
  end

  @doc """
  URL encode key / value pair
  """
  def encode_attribute(k, v) when is_list(v) do
    v
    |> Enum.map(fn vv -> "#{k}[]=#{encode_value(vv)}" end)
    |> Enum.join("&")
  end
  def encode_attribute(k, v), do: "#{k}=#{encode_value(v)}"

  @doc """
  URL encode a value
  """
  def encode_value(v), do: URI.encode_www_form("#{v}")
end
