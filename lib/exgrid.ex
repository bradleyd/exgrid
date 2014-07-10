defmodule ExGrid do
  defstruct [:api_key, :api_user]

  def credentials(%{api_key: key, api_user: user}) do
    Map.merge(%ExGrid{api_key: key, api_user: user})
  end

  def credentials(%{api_key: _}) do
    {:error}
  end

  def credentials(%{api_user: _}) do
    {:error}
  end


  def credentials(creds) do
    Map.merge(%ExGrid{}, creds)
  end
  
end
