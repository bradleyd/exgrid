defmodule ExGrid.Profile do
  import ExGrid.Util
  alias ExGrid.HTTPHandler


  def get(credentials) do
    {_code, _body} = HTTPHandler.get(credentials, build_url("profile", "get", credentials))
  end

  @doc """
  Edit profile settings.

  * profile settings must be a Map

  ### Possible settings
  ```  
  first_name Your first name
  last_name Your last name
  address Company address
  city City where your company is located            
  state State where your company is located
  country Country where your company is located
  zip Zipcode where your company is located        
  phone Valid phone number where we can reach you
  website  Company website
  ```

  ## Examples
  iex> ExGrid.Profile.set(creds, %{ first_name: "Bob", last_name: "Dobalina" })\r\n
  { 200, #HashDict<[{"message", "success"}]>}
  """
  def set(credentials, profile_attributes) do
    {_code, _body} = HTTPHandler.post(credentials, build_url("profile", "set"), build_form_data(credentials, profile_attributes))
  end
end
