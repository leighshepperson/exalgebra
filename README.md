# ExAlgebra

##### Vector

Functions that operate on vectors and vector sets. 

Vectors are represented as lists of numbers, i.e. `[number]'. Vector sets are represented as lists of vectors, i.e. `[[number]]`. 

The input to these functions are not usually checked. For example, linear independence of a vector set or counting the number of elements in a vector.The library contains functions to help the user accomplish these tasks themselves.

##### Matrix
Functions that operate on matrices. 

Matrices are represented as lists of lists numbers, i.e. `[[number]]'. The rows are represented by the inner lists and the columns are represented by the elements of the inner lists. This means the length of the inner lists must all be the same.

The input to these functions are not usually checked. For example, the number of rows and columns of a matrix. The library contains functions to help the user accomplish these tasks themselves.

## Installation

The package is [available in Hex](https://hex.pm/packages/exalgebra), and it can be installed as:

  1. Add exalgebra to your list of dependencies in `mix.exs`:

        def deps do
          [{:exalgebra, "~> 0.0.3"}]
        end

  2. Ensure exalgebra is started before your application:

        def application do
          [applications: [:exalgebra]]
        end

