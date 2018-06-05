defmodule Settings.MixProject do
  use Mix.Project

  @organization "fotobouda"

  def project do
    [
      app: :settings,
      version: "2.0.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      description: "The settings server.",
      deps: deps(),
      package: package(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.18.1", only: :dev},
      {:excoveralls, "~> 0.7", only: :test},
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:poison, "~> 3.1"},
    ]
  end

  defp package() do
    [
      maintainers: [
        "Jindrich K. Smitka <smitka.j@gmail.com>",
        "Ondrej Tucek <ondrej.tucek@gmail.com>",
      ],
      licenses: ["Private"],
      organization: @organization,
      links: %{
        "GitHub" => "https://github.com/s-m-i-t-a/fotobouda-settings",
      }
    ]
  end
end
