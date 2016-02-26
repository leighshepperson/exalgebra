# ExAlgebra

Linear Algebra library.

##### Vector
Functions that operate on vectors and vector sets. 

Vectors are represented as lists of numbers `[number]`. 

Vector sets are represented as lists of vectors `[[number]]`.

##### Matrix
Functions that operate on matrices. 

Matrices are represented as lists of lists of numbers `[[number]]`. 

Rows are represented by the inner lists.

Columns are represented by the elements of the inner lists. 

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

