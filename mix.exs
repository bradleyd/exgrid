defmodule ExGrid.Mixfile do
  use Mix.Project

  def project do
    [app: :exgrid,
     version: "0.1.0",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:httpotion]]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [ {:httpotion, git: "https://github.com/myfreeweb/httpotion.git"},
      {:json, github: "cblage/elixir-json"},
      {:timex, "~> 0.13.2"}
    ]
  end
end
