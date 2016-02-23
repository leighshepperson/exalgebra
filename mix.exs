defmodule ExAlgebra.Mixfile do
  use Mix.Project

  def project do
    [app: :exalgebra,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps, 
     description: description,
     package: package]
  end

  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:eye_drops, "~> 1.0.0"}, {:credo, "~> 0.3", only: [:dev, :test]}]
  end

  defp description do
    """
    ExAlgebra is a library collecting common functions used in linear algebra.
    """
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Leigh Shepperson"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/leighshepperson/exalgebra",
              "Docs" => "https://github.com/leighshepperson/exalgebra/"}]
  end
end
