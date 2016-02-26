defmodule ExAlgebra.Vector do
  @moduledoc """
  Functions that operate on vectors and vector sets. 

  Vectors are represented as lists of numbers, i.e. `[number]'. Vector sets are represented as lists of vectors, i.e. `[[number]]`. 

  The input to these functions are not usually checked. For example, linear independence or counting the number of elements in a vector.
  This is due to performance issues related to these operations. However, the library contains functions to help the user accomplish this task themselves.

  """

  import :math, only: [sqrt: 1]
  alias ExAlgebra.Matrix, as: Matrix

  @doc """
  Computes the addition of two vectors. This is a new vector with entries equal to the sum of the pair of vector's corresponding entries. 
  The input vectors should have the same length: Since the time taken to compute the length of a list increases linearly we do
  not check the length of the inputs before calculation. However, if the input vectors are of different size, a clause match
  error will be thrown. 
  ## Examples
      iex> ExAlgebra.Vector.add([1, 2, 3], [2, 3, 4])
      [3, 5, 7]
  """
  @spec add([number], [number]) :: [number]
  def add([], []), do: []
  def add([u_head | u_tail], [v_head | v_tail]) do
    [u_head + v_head | add(u_tail, v_tail)]
  end

  @doc """
  Computes the subtraction of two vectors. This is a new vector with entries equal to the difference of the pair of vector's corresponding entries. 
  The input vectors should have the same length: Since the time taken to compute the length of a list increases linearly we do
  not check the length of the inputs before calculation. However, if the input vectors are of different size, a clause match
  error will be thrown. 
  ## Examples
      iex> ExAlgebra.Vector.subtract([1, 2, 3], [2, 3, 4])
      [-1, -1, -1]
  """
  @spec subtract([number], [number]) :: [number]
  def subtract([], []), do: []
  def subtract([u_head | u_tail], [v_head | v_tail]) do
    [u_head - v_head | subtract(u_tail, v_tail)]
  end

  @doc """
  Computes the multiple of a vector by a scalar value.
  ## Examples
      iex> ExAlgebra.Vector.scalar_multiply([1, 2, 3], 2.5)
      [2.5, 5.0, 7.5]
  """
  @spec scalar_multiply([number], number) :: [number]
  def scalar_multiply(u, scalar), do: u |> Enum.map(&(&1 * scalar))

  @doc """
  Computes the dot product of a pair of vectors. This is the sum of the products of the pair of vector's corresponding entries. 
  The input vectors should have the same length: Since the time taken to compute the length of a list increases linearly we do
  not check the length of the inputs before calculation. However, if the input vectors are of different size, a clause match
  error will be thrown. 
  ## Examples
      iex> ExAlgebra.Vector.dot([1, 2, 3], [2, 3, 4])
      20
  """
  @spec dot([number], [number]) :: number
  def dot([], []), do: 0
  def dot([u_head | u_tail], [v_head | v_tail]) do
    u_head * v_head + dot(u_tail, v_tail)
  end
  
  @doc """
  Computes the magnitude of a vector. This is also known as the length of a vector.
  ## Examples
      iex> ExAlgebra.Vector.magnitude([1, 2, 3, 4])
      5.477225575051661
  """
  @spec magnitude([number]) :: number
  def magnitude(u), do: u |> sqr_magnitude |> sqrt

  @doc """
  Computes the square of the magnitude of a vector. This avoids the expensive square root operation.
  ## Examples
      iex> ExAlgebra.Vector.sqr_magnitude([1, 2, 3, 4])
      30
  """
  @spec sqr_magnitude([number]) :: number
  def sqr_magnitude(u), do: u |> dot(u)

  @doc """
  Computes the normalization of a vector. This is a vector pointing in the same direction, but with magnitude `1`. 
  ## Examples
      iex> ExAlgebra.Vector.normalize([1, 2, 3, 4])
      [0.18257418583505536, 0.3651483716701107, 0.5477225575051661, 0.7302967433402214]
  """
  @spec normalize([number]) :: [number]
  def normalize(u), do: u |> scalar_multiply(1 / magnitude(u))

  @doc """
  Computes the length of the line segment connecting vectors `u` and `v`.
  ## Examples
      iex> ExAlgebra.Vector.distance([1, 2, 3], [4, 5, 6])
      5.196152422706632
  """
  @spec distance([number], [number]) :: number
  def distance(u, v), do: (u |> subtract(v)) |> magnitude 

  @doc """
  Returns true if and only if a pair of vectors are orthogonal. This is equivalent to a pair of vectors being perpendicular in Euclidian space.
  ## Examples
      iex> ExAlgebra.Vector.is_orthogonal?([1, 1, 1], [-2, 1, 1])
      true

      iex> ExAlgebra.Vector.is_orthogonal?([1, 1, 1], [1, 1, 1])
      false 
  """
  @spec is_orthogonal?([number], [number]) :: boolean
  def is_orthogonal?(u, v), do: u |> dot(v) == 0


  @doc """
  Computes the scalar projection of `u` onto `v`. This is the length of the orthogonal projection of `u` onto `v`.
  ## Examples
      iex> ExAlgebra.Vector.scalar_projection([4, 1], [2, 3])
      3.05085107923876     
  """
  @spec scalar_projection([number], [number]) :: number
  def scalar_projection(u, v), do: dot(u, v) / magnitude(v)

  @doc """
  Computes the vector projection of a pair of vectors `u, v`. This is the orthogonal projection of `u` onto `v`.
  ## Examples
      iex> ExAlgebra.Vector.vector_projection([0, 1, 1, 0], [1, 2, 4, 0])
      [0.2857142857142857, 0.5714285714285714, 1.1428571428571428, 0.0]
  """
  @spec vector_projection([number], [number]) :: [number]
  def vector_projection(u, v) do
    v |> scalar_multiply(dot(u, v) / sqr_magnitude(v))
  end

  @doc """
  Computes a vector based on an input vector that is orthogonal to each vector in the set of linearly independent vectors. The input vector must also
  form a linearly independent set when it is part of the linearly independent vectors. Use `ExAlgebra.Vector.is_linearly_independent?` to test
  for linear independence. 
  ## Examples
      iex> ExAlgebra.Vector.create_orthogonal_vector([0, 1, 1, 0], [[1, 2, 4, 0]])
      [-0.2857142857142857, 0.4285714285714286, -0.1428571428571428, 0.0]
  """
  @spec create_orthogonal_vector([number], [[number]]) :: [number]
  def create_orthogonal_vector(u, linearly_independent_vectors) do
    linearly_independent_vectors |> List.foldl(u, &subtract(&2, vector_projection(&2, &1)))
  end
  
  @doc """
  Computes an orthogonal basis from a set of linearly independent vectors. Use `ExAlgebra.Vector.is_linearly_independent?` to test
  for linear independence.
  ## Examples
      iex> ExAlgebra.Vector.create_orthogonal_basis([[1, 2, 4, 0], [0, 1, 1, 0], [0, 3, 1, 4]])
      [[1, 2, 4, 0],
            [-0.2857142857142857, 0.4285714285714286, -0.1428571428571428, 0.0],
            [0.6666666666666664, 0.3333333333333335, -0.3333333333333336, 4.0]]
  """
  @spec create_orthogonal_basis([[number]]) :: [[number]]
  def create_orthogonal_basis([u | remaining_vectors] = _linearly_independent_vectors) do
    remaining_vectors |> List.foldl([u], &(&2 ++ [create_orthogonal_vector(&1, &2)]))
  end

  @doc """
  Computes an orthonormal basis from a set of linearly independent vectors. This is the modified version of the *Gram–Schmidt* process. 
  Use ExAlgebra.Vector.is_linearly_independent? to test for linear independence.
  ## Examples
      iex> ExAlgebra.Vector.create_orthonormal_basis([[1, 1, 1], [2, 1, 0], [5, 1, 3]])
      [[0.5773502691896258, 0.5773502691896258, 0.5773502691896258], [0.7071067811865475, 0.0, -0.7071067811865475], [0.4082482904638631, -0.8164965809277261, 0.4082482904638631]]
  """
  @spec create_orthonormal_basis([[number]]) :: [[number]]
  def create_orthonormal_basis(linearly_independent_vectors) do
    linearly_independent_vectors |> create_orthogonal_basis |> Enum.map(&normalize(&1))
  end

  @doc """
  Returns true if and only if a set of vectors are linearly independent.
  ## Examples
    iex> ExAlgebra.Vector.is_linearly_independent?([[1, 1, 1], [2, 1, 0], [5, 1, 3]])
    true

    iex> ExAlgebra.Vector.is_linearly_independent?([[2, 3, 5], [-1, -4, -10], [1, -2, -8]])
    false
  """
  @spec is_linearly_independent?([[number]]) :: boolean
  def is_linearly_independent?(vectors), do: Matrix.det(vectors) != 0

end