defmodule ExGrid.Message do
  defstruct to: nil, subject: nil, text: nil, html: nil, from: nil, bcc: nil

  @doc """
  this is the minimum needed to send an email
  """
  def new(%{to: to, subject: subject, text: text, from: from})  do
    {:ok, %ExGrid.Message{to: to, subject: subject, text: text, from: from} }
  end
  
  def new(%{to: to, subject: subject, html: html, from: from})  do
    {:ok, %ExGrid.Message{to: to, subject: subject, html: html, from: from} }
  end

  def new(message) when message == %{} do
    {:error, "Missing attributes"}
  end

  def new(message) when is_map(message) do
    case validate_message(message) do
      { :ok, _ } ->
        { :ok, Map.merge(%ExGrid.Message{}, message) }
      { :error, error_message} ->
        { :error, error_message }
    end
  end

  def new() do
    {:error, "need attrbiutes to send a message"}
  end

  defp validate_message(msg) do
    case msg do
     %{ to: _, subject: _, text: _, from: _, bcc: _} ->
       { :ok, msg }
     %{ to: _, subject: _, html: _, from: _, bcc: _} ->
       { :ok, msg }
     %{ to: _, subject: _, html: _, from: _} ->
       { :ok, msg }
     _ ->
       { :error, "missing default attributes to send message" }
    end
  end
  

end
