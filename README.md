# ExAlgebra

ExAlgebra is a library collecting common functions used in linear algebra. The current implementations are naive and are not guaranteed to be efficient.

Vectors are represented by lists of numbers, i.e. [1, 2, 3]. Matrices are represented by a list (rows) of lists(columns) of numbers, i.e. [[1, 2, 3], [3, 3, 4], [3, 5, 6]].

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add exalgebra to your list of dependencies in `mix.exs`:

        def deps do
          [{:exalgebra, "~> 0.0.1"}]
        end

  2. Ensure exalgebra is started before your application:

        def application do
          [applications: [:exalgebra]]
        end

