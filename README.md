ExGrid
======

Elixir library to interact with Sendgrid's REST API

## Usage

Send an email
#ExGrid.Mail.send requires a credential map and a message map
* note api_user and api_key must contain those keys

```elixir
creds = %{api_user: 'bob', api_key: 'Dobalina'}
mesage = %{to: 'foo@example.com', subject: 'hello world', from: 'me@myselfandi.com'}
{code, body} = ExGrid.Mail.send(creds, message)
```

`body` is a json return
`code` is the HTTP response code

Or you can create a message struct to be passed around

```elixir
message = ExGrid.Message.new(%{to: 'foo@example.com', subject: 'hello world', from: 'me@mysefandi.com'})

{code, body} = ExGrid.Mail.send(creds, message)
code #=> 200
body #=> #HashDict<[{"message", "success"}]>
```

 
