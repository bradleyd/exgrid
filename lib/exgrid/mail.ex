defmodule ExGrid.Mail do
  
  alias ExGrid.HTTPHandler


  def send(creds, message) do
    {code, body} = HTTPHandler.post(creds, url, build_form_data(creds, message))
  end

  defp build_form_data(%ExGrid{} = creds, %ExGrid.Message{} = message) do
    build_form_data(Map.from_struct(creds), Map.from_struct(message))
  end

  defp build_form_data(creds, message) do
    full_message = Map.merge(creds, message)

    {name_from, email_from} = split_email(full_message.from)
    {name_to, email_to} = split_email(full_message.to)

    full_message = Map.merge(full_message, %{
      fromname: name_from,
      from: email_from,
      toname: name_to,
      to: email_to
    })

    Enum.map(Map.to_list(full_message), fn {k,v} -> ("#{k}=#{v}") end ) |>
    Enum.join("&")
  end

  defp url do
    "https://sendgrid.com/api/mail.send.json"
  end

  defp split_email(nil) do
    {nil, nil}
  end

  defp split_email(full_email) do
    [_, name, email] = Regex.run(~r/^([^<]*?)\s*?<([^>]*)>/, full_email) || [nil, nil, full_email]
    {name, email}
  end
end
