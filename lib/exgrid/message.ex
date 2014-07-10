defmodule ExGrid.Message do
  defstruct to: nil, subject: nil, text: nil, html: nil, from: nil, bcc: nil

  def new() do
    {:error, "need #{__struct__} to send message"}
  end

  def new(message) when message == %{} do
    {:error, "Missing attributes", %ExGrid.Message{}}
  end

  def new(message) do
    struct = Map.merge(%ExGrid.Message{}, message)
    {:ok, struct}
  end

  defp validate_message(msg) do
    {:error, msg, "missing to"}
  end
end
