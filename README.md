# ExAlgebra

The ExAlgebra library is a collection of functions that are commonly used in linear algebra. Vectors and Matrices are intuitively represented by lists. There is no validation performed by the functions in ExAlgebra as the inputs to the functions are assumed to be well defined within a reasonable scope.

##### Vector
The ExAlgebra Vector module is a collection of functions that perform
computations on vectors. Vectors are represented by lists of numbers.

##### Vector3
The ExAlgebra Vector3 module is a collection of functions that perform computations on 3-vectors. 3-vectors are represented by lists with exactly
three elements.

##### Matrix
The Exalgebra Matrix module is a collection of functions that perform computations on matrices. Matrices are represented by lists of lists of numbers, where the inner lists represent the rows of the matrix.

## Installation

The package is [available in Hex](https://hex.pm/packages/exalgebra), and it can be installed as:

  1. Add exalgebra to your list of dependencies in `mix.exs`:

        def deps do
          [{:exalgebra, "~> 0.0.5"}]
        end

  2. Ensure exalgebra is started before your application:

        def application do
          [applications: [:exalgebra]]
        end

