defmodule ExGrid.Message do
  defstruct to: nil, subject: nil, text: nil, html: nil, from: nil, bcc: nil, files: nil

  @moduledoc """
  Create a Message map
  
  ## Examples

  iex> {:ok, message} = ExGrid.Message.new([to: "foo", from: "me@myself.com", subject: "hello", text: "how are you?"])   
  """

  @doc """
  Creates a message.
  
  The minimum needed to send an email

  [to: "foo", from: "me@myself.com", subject: "hello", text: "how are you?"]


  When adding attachments, they must be in this form files[file1.jpg]=file1.jpg
  """
  def new() do
    {:error, "need attrbiutes to send a message"}
  end

  def new([]) do
    {:error, "Missing attributes"}
  end

  def new(opts)  do
    to = Keyword.fetch!(opts, :to)
    from = Keyword.fetch!(opts, :from)
    subject = Keyword.fetch!(opts, :subject)
    text = Keyword.fetch!(opts, :text)
    {:ok, %ExGrid.Message{to: to, subject: subject, text: text, from: from} }
  end

  def new(opts)  do
    to = Keyword.fetch!(opts, :to)
    from = Keyword.fetch!(opts, :from)
    subject = Keyword.fetch!(opts, :subject)
    html = Keyword.fetch!(opts, :html)
    {:ok, %ExGrid.Message{to: to, subject: subject, html: html, from: from} }
  end

  def new(opts)  do
    to = Keyword.fetch!(opts, :to)
    from = Keyword.fetch!(opts, :from)
    subject = Keyword.fetch!(opts, :subject)
    html = Keyword.fetch!(opts, :html)
    text = Keyword.fetch!(opts, :text)
    {:ok, %ExGrid.Message{to: to, subject: subject, text: text, html: html, from: from} }
  end

  def new(opts)  do
    to = Keyword.fetch!(opts, :to)
    from = Keyword.fetch!(opts, :from)
    subject = Keyword.fetch!(opts, :subject)
    html = Keyword.get(opts, :html)
    text = Keyword.get(opts, :text)
    files = Keyword.fetch!(opts, :file)
    {:ok, %ExGrid.Message{to: to, subject: subject, text: text, html: html, from: from, files: files} }
  end

end
