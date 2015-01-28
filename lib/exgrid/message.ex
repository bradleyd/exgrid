defmodule ExGrid.Message do
  defstruct to: nil, from: nil, subject: nil, replyto: nil, bcc: nil, text: nil, html: nil, files: nil

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

    replyto = Keyword.get(opts, :replyto)
    text = Keyword.get(opts, :text)
    html = Keyword.get(opts, :html)
    files = Keyword.get(opts, :files)

    cond do
      (text || html) -> {:ok, %ExGrid.Message{
        to: to,
        from: from,
        subject: subject,
        replyto: replyto,
        text: text,
        html: html,
        files: files
      }}
      true -> {:error, "Missing attribute: text or html"}
    end
  end

end
