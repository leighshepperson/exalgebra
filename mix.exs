defmodule ExAlgebra.Mixfile do
  use Mix.Project

  def project do
    [app: :exalgebra,
     version: "0.0.4",
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

  defp deps do
    [{:eye_drops, "~> 1.0.0"},
     {:credo, "~> 0.3", only: [:dev, :test]},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.11", only: :dev}]
  end

  defp description do
    """
    This library collects a host of common functions that can be used in linear algebraic computations.
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
