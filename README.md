ExGrid
======

[![Build Status](https://travis-ci.org/bradleyd/exgrid.svg?branch=master)](https://travis-ci.org/bradleyd/exgrid) [![Hex pm](http://img.shields.io/hexpm/v/exgrid.svg)](https://hex.pm/packages/exgrid)


Elixir library to interact with Sendgrid's REST API

### This is a WIP, YMMV

## Installation
Hex does not include git repo's from mix, so you will have to add ibrowse to your deps.

In order to install it via hex, add `exgrid` and `ibrowse` package into the deps list of your mix.exs.

```elixir
  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.0"},
      {:exgrid, "~> 0.2.3"}
    ]
  end
```

## Usage

Send an email
#### ExGrid.Mail.send requires a credential Map and a message Map
* note api_user and api_key must contain those keys or you will get a match error

```elixir
{ :ok, creds } = ExGrid.credentials(%{api_key: key, api_user: user})
{ :ok, message } = ExGrid.Message.new([to: 'foo@example.com', subject: 'hello world', from: 'me@mysefandi.com'])

{code, body} = ExGrid.Mail.send(creds, message)
code #=> 200
body #=> #HashDict<[{"message", "success"}]>
```
`body` is a json return
`code` is the HTTP response code

#### Profile
Get your profile

```elixir
{200, body } = ExGrid.Profile.get(creds)
IO.inspect body #=>
[#HashDict<[{"first_name", "John"}, {"username", "foo@fakedomain.com"}, {"website_access", "true"}, {"phone", "123456789"}, {"state", "CO"}, {"last_name", "Doe"}, {"address2", ""}, {"city", "Denver"}, {"email", "foo@fakedomain.com"}, {"website", "http://sendgrid.com"}, {"country", "US"}, {"active", "true"}, {"zip", "80020"}, {"address", "123 main st"}]>]
```

Set a profile attribute 
 
```elixir
{200, body} = ExGrid.Profile.set(creds, %{address: "456 Main st"})
IO.inspect body #=> #HashDict<[{"message", "success"}]>
```

#### Bounces

[Please see docs for all parameters](https://sendgrid.com/docs/API_Reference/Web_API/bounces.html)
 
```elixir
{200, body} = ExGrid.Bounces.get(creds)
```

```elixir
# return the `created` time for each bounce
{200, body} = ExGrid.Bounces.get(creds, %{date: 1})
```

remove bounces

```elixir
{200, body} = ExGrid.Bounces.remove(creds, %{type: "soft"}) 
IO.inspect body #=> {"message", "success"}
```

```elixir
{200, body} = ExGrid.Bounces.remove(creds, %{email: "foobarbazwoot@nowhereland.biz"}) 
IO.inspect body #=> {"message", "success"}
```

You can even get bounce counts

```elixir
{200, body} = ExGrid.Bounces.count(creds)
IO.inspect body #=> {"count", "4"}
```

#### Blocks
[Please see docs for all parameters](https://sendgrid.com/docs/API_Reference/Web_API/blocks.html)
 
```elixir
{200, body} = ExGrid.Blocks.get(creds)
```

```elixir
# return the `created` time for each block
{200, body} = ExGrid.Blocks.get(creds, %{date: 1})
```

remove blocks

* only parameter accepted is `email`

```elixir
{200, body} = ExGrid.Blocks.remove(creds, %{email: "foobarbazwoot@nowhereland.biz"}) 
IO.inspect body #=> {"message", "success"}
```

You can even get block counts

```elixir
{200, body} = ExGrid.Blocks.count(creds)
IO.inspect body #=> {"count", "4"}
```

#### Statistics
[Please see docs for all parameters](https://sendgrid.com/docs/API_Reference/Web_API/Statistics.html)
 
```elixir
{200, body} = ExGrid.Statistics.get(creds)
IO.inspect body #=>
HashDict<[
[
   {
      "date": "2014-02-26",
      "delivered": 314,
      "unsubscribes": 1,
      "invalid_email": 5,
      "bounces": 9,
      "repeat_unsubscribes": 2,
      "unique_clicks": 65,
      "blocked": 3,
      "spam_drop": 5,
      "repeat_bounces": 8,
      "repeat_spamreports": 9,
      "requests": 350,
      "spamreports": 1,
      "clicks": 78,
      "opens": 80,
      "unique_opens": 70
]>

```

Number of days in the past to include statistics (Includes today)
```elixir
{200, body} = ExGrid.Statistics.get(creds, %{days: 1})
```

List all categories
```elixir
{200, body} = ExGrid.Statistics.categories(creds)
```

You can even get aggregate stats

```elixir
{200, body} = ExGrid.Statistics.get(creds, %{aggregate: 1})
```

### Tests
You must supply your credentials as environment vars to run tests.

```bash
API_KEY="secret" API_USER="foo@example.com" mix test test
```
