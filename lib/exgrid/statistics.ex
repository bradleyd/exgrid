defmodule ExGrid.Statistics do
  
  alias ExGrid.HTTPHandler


  def days(creds, days) do
    {code, body} = HTTPHandler.post(creds, url, build_form_data(creds, days))
  end

  defp build_form_data(creds, data) do
    payload = Dict.merge(creds, data)
    Enum.map(Map.to_list(payload), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end

  defp url do
    "https://api.sendgrid.com/api/stats.get.json"
  end
end
