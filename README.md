ExGrid
======

[![Build Status](https://travis-ci.org/bradleyd/exgrid.svg?branch=master)](https://travis-ci.org/bradleyd/exgrid) [![Hex.pm](http://img.shields.io/hexpm/v/exgrid.svg)](https://hex.pm/packages/exgrid)


Elixir library to interact with [Sendgrid's V2 Web API](https://sendgrid.com/docs/API_Reference/Web_API/index.html)

#### This is a WIP, YMMV

## Upgrading from `0.4.0` to `1.0.0`

The reason the version got bumped to `1.0.0` is because I replaced all traces of `Dict` with `Map`.  A lot of the functions returned a `Dict` and this may break some folks code.

There are some other changes to dep versions which may be an issue in your application as well.  If this is the case, stay with `0.X` branch.  I will try to keep `0.X` up to date as best I can for these reasons.  However, there will not be any new dev time for the `0.X` series.  Only bug fixes.

## Installation

In order to install it via hex, add `exgrid` and `ibrowse` package into the deps list of your mix.exs.

```elixir
  defp deps do
    [
      {:exgrid, "~> 1.0"}
    ]
  end
```

## Quick Start

#### Send an email

* `ExGrid.Message.new` requires a `text` and/or `html` body

```elixir
{:ok, creds }   = ExGrid.credentials(%{api_key: "mysecretpassword", api_user: "foo@example.com"})
{:ok, message } = ExGrid.Message.new([to: "bar@example.com", subject: "hello world", from: "foo@example.com", text: "this is a test message"])

{code, body}    = ExGrid.Mail.send(creds, message)

{200, %{"message" => "success"}}
```

## Usage

#### Profile

###### Get your profile

```elixir
{200, body } = ExGrid.Profile.get(creds)
IO.inspect body #=>
[%{"first_name", "John"}, {"username", "foo@fakedomain.com"}, {"website_access", "true"}, {"phone", "123456789"}, {"state", "CO"}, {"last_name", "Doe"}, {"address2", ""}, {"city", "Denver"}, {"email", "foo@fakedomain.com"}, {"website", "http://sendgrid.com"}, {"country", "US"}, {"active", "true"}, {"zip", "80020"}, {"address", "123 main st"}]
```

###### Set a profile attribute

```elixir
{200, body} = ExGrid.Profile.set(creds, %{address: "456 Main st"})
IO.inspect body #=> %{"message", "success"}
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

###### Remove bounces

```elixir
{200, body} = ExGrid.Bounces.remove(creds, %{type: "soft"})
IO.inspect body #=> {"message", "success"}
```

```elixir
{200, body} = ExGrid.Bounces.remove(creds, %{email: "foobarbazwoot@nowhereland.biz"})
IO.inspect body #=> {"message", "success"}
```

###### You can even get bounce counts

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

###### Remove blocks

* only parameter accepted is `email`

```elixir
{200, body} = ExGrid.Blocks.remove(creds, %{email: "foobarbazwoot@nowhereland.biz"})
IO.inspect body #=> {"message", "success"}
```

###### You can even get block counts

```elixir
{200, body} = ExGrid.Blocks.count(creds)
IO.inspect body #=> {"count", "4"}
```

#### Statistics

[Please see docs for all parameters](https://sendgrid.com/docs/API_Reference/Web_API/Statistics.html)

```elixir
{200, body} = ExGrid.Statistics.get(creds)
IO.inspect body #=>
[
   %{
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
      "unique_opens": 70}
]

```

###### Number of days in the past to include statistics (Includes today)

```elixir
{200, body} = ExGrid.Statistics.get(creds, %{days: 1})
```

###### List all categories

```elixir
{200, body} = ExGrid.Statistics.categories(creds)
```

###### You can even get aggregate stats

```elixir
{200, body} = ExGrid.Statistics.get(creds, %{aggregate: 1})
```

#### Tests

The tests are a unit style and do not go out and hit SendGrid.

```Elixir
mix test
```
