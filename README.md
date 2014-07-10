ExGrid
======

Elixir library to interact with Sendgrid's REST API

## Usage

Send an email
#ExGrid.Mail.send requires a credential map and a message map
* note api_user and api_key must contain those keys

```elixir
creds   = ExGrid.credentials(%{api_key: key, api_user: user})
message = ExGrid.Message.new(%{to: 'foo@example.com', subject: 'hello world', from: 'me@mysefandi.com'})

{code, body} = ExGrid.Mail.send(creds, message)
code #=> 200
body #=> #HashDict<[{"message", "success"}]>
```
`body` is a json return
`code` is the HTTP response code


 
