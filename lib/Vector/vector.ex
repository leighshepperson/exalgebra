defmodule ExAlgebra.Vector do
  @moduledoc """
  *ExAlgebra.Vector* contains functions used in vector algebra.
  """

  import :math, only: [sqrt: 1]
  alias ExAlgebra.Matrix, as: Matrix

  @doc """
    Returns the addition of two vectors.
    ##### Examples

        iex> vector = [1, 2, 3]
        [1, 2, 3]

        iex> vector |> ExAlgebra.Vector.add([2, 3, 4])
        [3, 5, 7]
  """
  @spec add([number], [number]) :: [number]
  def add([], []), do: []
  def add([h1 | t1], [h2 | t2]) do
    [h1 + h2 | add(t1, t2)]
  end

  @doc """
    Returns the subtraction of two vectors.
    ##### Examples

        iex> vector = [1, 2, 3]
        [1, 2, 3]

        iex> vector |> ExAlgebra.Vector.subtract([2, 3, 4])
        [-1, -1, -1]
  """
  @spec subtract([number], [number]) :: [number]
  def subtract([], []), do: []
  def subtract([h1 | t1], [h2 | t2]) do
    [h1 - h2 | subtract(t1, t2)]
  end

  @doc """
    Returns the multiple of a vector by a scalar.
    ##### Examples

        iex> vector = [1, 2, 3]
        [1, 2, 3]

        iex> vector |> ExAlgebra.Vector.scalar_multiply(2.5)
        [2.5, 5, 7.5]
  """
  @spec scalar_multiply([number], number) :: [number]
  def scalar_multiply(vector, scalar), do: vector |> Enum.map(&(&1 * scalar))

  @doc """
    Returns the dot product of two vectors.
    ##### Examples

        iex> vector = [1, 2, 3]
        [1, 2, 3]

        iex> vector |> ExAlgebra.Vector.dot([2, 3, 4])
        [2, 6, 12]
  """
  @spec dot([number], [number]) :: number
  def dot([], []), do: 0
  def dot([h1 | t1], [h2 | t2]) do
    h1 * h2 + dot(t1, t2)
  end
  
  @doc """
    Returns the magnitude of a vector.
    ##### Examples

        iex> vector = [1, 2, 3, 4]
        [1, 2, 3, 4]

        iex> vector |> ExAlgebra.Vector.magnitude
        5.4772255751
  """
  @spec magnitude([number]) :: number
  def magnitude(vector), do: vector |> sqr_magnitude |> sqrt

  @doc """
    Returns the square of the magnitude of a vector.
    ##### Examples

        iex> vector = [1, 2, 3, 4]
        [1, 2, 3, 4]

        iex> vector |> ExAlgebra.Vector.sqr_magnitude
        30
  """
  @spec sqr_magnitude([number]) :: number
  def sqr_magnitude(vector), do: vector |> dot(vector)

  @doc """
    Returns the normalization of a vector.
    ##### Examples

        iex> vector = [1, 2, 3, 4]
        [1, 2, 3, 4]

        iex> vector |> ExAlgebra.Vector.sqr_magnitude
        [0.1825741858, 0.3651483717, 0.5477225575, 0.7302967433]
  """
  @spec normalize([number]) :: [number]
  def normalize(vector), do: vector |> scalar_multiply(1 / magnitude(vector))

  @doc """
    Returns the distance between two vectors.
    ##### Examples

        iex> vector = [1, 2, 3]
        [1, 2, 3]

        iex> vector |> ExAlgebra.Vector.sqr_magnitude([4, 5, 6])
        5.1961524227
  """
  @spec distance([number], [number]) :: number
  def distance(vector_one, vector_two), do: (vector_one |> subtract(vector_two)) |> magnitude 

  @doc """
    Returns true iff two vectors are orthogonal.
    ##### Examples

        iex> vector = [1, 1, 1]
        [1, 1, 1]

        iex> vector |> ExAlgebra.Vector.is_orthogonal?([-2, 1, 1])
        true

        iex> vector = [1, 1, 1]
        [1, 1, 1]

        iex> vector |> ExAlgebra.Vector.is_orthogonal?([1, 1, 1])
        false 
  """
  @spec is_orthogonal?([number], [number]) :: boolean
  def is_orthogonal?(vector_one, vector_two), do: vector_one |> dot(vector_two) == 0

  @doc """
    Returns the projection of one vector by another.
    ##### Examples

        iex> vector = [1, 2, 4, 0]
        [1, 2, 4, 0]

        iex> vector |> ExAlgebra.Vector.project([0, 1, 1, 0])
        [2/7, 4/7, 8/7, 0]
  """
  @spec project([number], [number]) :: [number]
  def project(vector_one, vector_two) do
    vector_one |> scalar_multiply(dot(vector_one, vector_two) / dot(vector_one, vector_one))
  end

  @doc """
    Returns an orthogonal vector from a vector and a set of linearly 
    independent vectors.
    ##### Examples

        iex> vector = [0, 1, 1, 0]
        [0, 1, 1, 0]

        iex> vector |> ExAlgebra.Vector.create_orthogonal_vector([[1, 2, 4, 0]])
        [-2/7, 3/7, -1/7, 0]
  """
  @spec project([number], [[number]]) :: [number]
  def create_orthogonal_vector(vector, linearly_independent_vectors) do
    linearly_independent_vectors |> List.foldl(vector, &subtract(&2, project(&1, &2)))
  end
  
  @doc """
    Returns an orthogonal basis from a set of linearly independent vectors.
    ##### Examples

        iex> vectors = [[1, 2, 4, 0], [0, 1, 1, 0], [0, 3, 1, 4]]
        [[1, 2, 4, 0], [0, 1, 1, 0], [0, 3, 1, 4]]

        iex> vectors |> ExAlgebra.Vector.create_orthogonal_basis
        [[1, 2, 4, 0], [-2/7, 3/7, -1/7, 0], [2/3, 1/3, -1/3, 4]]
  """
  @spec create_orthogonal_basis([[number]]) :: [[number]]
  def create_orthogonal_basis([first_vector | remaining_vectors] = _linearly_independent_vectors) do
    remaining_vectors |> List.foldl([first_vector], &(&2 ++ [create_orthogonal_vector(&1, &2)]))
  end

  @doc """
    Returns an orthonormal basis from a set of linearly independent vectors.
    This uses the modified Gram Schmidt algorithm. 
    ##### Examples

        iex> vectors = [[1, 1, 1], [2, 1, 0], [5, 1, 3]]
        [[1, 1, 1], [2, 1, 0], [5, 1, 3]]

        iex> vectors |> ExAlgebra.Vector.create_orthonormal_basis
        [[0.57735026919, 0.57735026919, 0.57735026919], [0.70710678118, 0, -0.70710678118], [0.40824829046, -0.81649658092, 0.40824829046]]
  """
  @spec create_orthogonal_basis([[number]]) :: [[number]]
  def create_orthonormal_basis(linearly_independent_vectors) do
    linearly_independent_vectors |> create_orthogonal_basis |> Enum.map(&normalize(&1))
  end

  @doc """
    Returns true if and only if a set of vectors are linearly independent.
    ##### Examples

        iex> vectors = [[1, 1, 1], [2, 1, 0], [5, 1, 3]]
        [[1, 1, 1], [2, 1, 0], [5, 1, 3]]

        iex> vector |> ExAlgebra.Vector.is_linearly_independent?
        true

        iex> vectors = [[2, 3, 5], [-1, -4, -10], [1, -2, -8]]
        [[2, 3, 5], [-1, -4, -10], [1, -2, -8]]

        iex> vector |> ExAlgebra.Vector.is_linearly_independent?
        false
  """
  @spec is_linearly_independent?([[number]]) :: boolean
  def is_linearly_independent?(vectors), do: Matrix.det(vectors) != 0

end