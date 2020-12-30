defmodule Hangman.MixProject do
  use Mix.Project

  def project do
    [
      app: :hangman,
      version: "0.1.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Hangman"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Hangman.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dictionary, "~> 0.1.1"}
    ]
  end

  defp description() do
    "This is the core layer of the Hangman server"
  end

  defp package() do
    [
      name: "hangman",
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/ryanyogan/hangman-layer"}
    ]
  end
end
