defmodule ExGrid.Mail do
  import ExGrid.API
  alias ExGrid.HTTPHandler

  def send(creds, message) do
    {_code, _body} = HTTPHandler.post(creds, build_url("mail", "send"), build_mail_form_data(creds, message))
  end

  defp build_mail_form_data(creds, message) do
    {name_from, email_from} = split_email(message.from)
    {name_to, email_to} = split_email(message.to)

    message = Map.merge(message, %{
      fromname: name_from,
      from: email_from,
      toname: name_to,
      to: email_to
    })

    build_form_data(creds, message)
  end

  defp split_email(emails) when is_list(emails) do
    (Enum.map emails, fn(email) -> split_email email end)
    |> (Enum.reduce {[], []}, fn(pair, acc) -> {[elem(pair, 0) | elem(acc, 0)], [elem(pair, 1) | elem(acc, 1)]} end)
    |> (fn pair -> {elem(pair, 0) |> Enum.reverse, elem(pair, 1) |> Enum.reverse} end).()
  end
  defp split_email(nil) do
    {nil, nil}
  end
  defp split_email(full_email) do
    [_, name, email] = Regex.run(~r/^([^<]*?)\s*?<([^>]*)>/, full_email) || [nil, nil, full_email]
    {cleanup_name(name), email}
  end

  defp cleanup_name(nil), do: nil
  defp cleanup_name(name) do
    name |> String.strip(?")
  end
end
