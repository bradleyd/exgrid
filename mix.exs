defmodule ExGrid.Mixfile do
  use Mix.Project

  def project do
    [app: :exgrid,
     version: "0.2.2",
     elixir: "~> 1.0.2",
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
    [ {:httpotion, "~> 1.0.0"},
      {:json, "~> 0.3.2"},
      {:timex, "~> 0.13.2"}
    ]
  end
end
