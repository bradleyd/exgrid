defmodule ExGrid.Mixfile do
  use Mix.Project

  def project do
    [app: :exgrid,
      version: "1.0.0",
      elixir: "~> 1.4",
      description: description(),
      package: package(),
      deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:httpotion, :timex]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.12", only: :dev},
      {:ibrowse, "~> 4.2"},
      {:httpotion, "~> 3.0"},
      {:json, "~> 1.0"},
      {:timex, "~> 3.0"}
    ]
  end

  def description do
    "Elixir bindings for SendGrid's REST API"
  end

  def package do
    [
      maintainers: ["Bradley Smith"],
      contributors: ["Bradley Smith"],
      licenses: ["The MIT License"],
      links: %{
        "GitHub" => "https://github.com/bradleyd/exgrid"
      }
    ]
  end
end
