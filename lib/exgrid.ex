defmodule ExGrid do
  defstruct [:api_key, :api_user]

  @doc """
  validate credentials
  Sendgrid API needs a user and key to authenticate
  %{api_key: key, api_user: user}
  """
  def credentials(%{api_key: key, api_user: user}) do
    { :ok, %ExGrid{api_key: key, api_user: user} }
  end

  def credentials(_) do
    {:error}
  end
end
