defmodule GoogleAiEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :google_ai_ex,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:req, "~> 0.4.11"},
      {:jason, "~> 1.4.1"},

      # Code quality
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:sobelow, "~> 0.11.1", only: :dev},
      {:excoveralls, "~> 0.15.0", only: :test}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get"],
      test: ["test"],
      check: ["compile --warning-as-errors", "credo --strict", "format --check-formatted", "sobelow --config", "dialyzer"]
    ]
  end
end
