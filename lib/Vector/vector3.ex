defmodule ExAlgebra.Vector3 do
  alias ExAlgebra.Vector, as: Vector
  alias ExAlgebra.Matrix, as: Matrix

  @moduledoc """
  The ExAlgebra Vector3 module is a collection of functions that perform
  computations on 3-vectors. 3-vectors are represented by lists with exactly
  three elements.
  """

  @doc """
  Computes the cross product.
  ##### Examples
      iex> ExAlgebra.Vector3.cross_product([2, 1, -1], [-3, 4, 1])
      [5, 1, 11]
  """
  @spec cross_product([number], [number]) :: [number]
  def cross_product([x, y, z], [u, v, w]), do: [y * w - z * v, z * u - x * w, x * v - y * u]

  @doc """
  Returns true if two vectors are parallel and false otherwise.
  ##### Examples
      iex> ExAlgebra.Vector3.is_parallel?([2, -4, 1], [-6, 12, -3])
      true
  """
  @spec is_parallel?([number], [number]) :: boolean
  def is_parallel?(u, v), do: cross_product(u, v) == [0, 0, 0]

  @doc """
  Computes the equation of the plain. This outputs a 4-vector with its 4<sup>th</sup> element
  containing the scalar part. For example, [11, -10, 4, -19] should be interpreted as 11x - 10y + 4z = -19.
  ##### Examples
      iex> ExAlgebra.Vector3.equation_of_plain([1, 3, 0], [3, 4, -3], [3, 6, 2])
      [11, -10, 4, -19]
  """
  @spec equation_of_plain([number], [number], [number]) :: [number]
  def equation_of_plain([x, y, z] = u, v, w) do
    [a, b, c] =  (v |> Vector.subtract(u)) |> cross_product(w |> Vector.subtract(u))
    [a, b, c, (x * a + b * y + c * z)]
  end

  @doc """
  Computes the area of a parallelogram.
  ##### Examples
      iex> ExAlgebra.Vector3.area_of_parallelogram([2, 1, -3], [1, 3, 2])
      :math.sqrt(195)
  """
  @spec area_of_parallelogram([number], [number]) :: number
  def area_of_parallelogram(u, v) do
    Vector.magnitude(u |> cross_product(v))
  end

  @doc """
  Computes the scalar triple product.
  ##### Examples
      iex> ExAlgebra.Vector3.scalar_triple_product([3, 2, 1], [-1, 3, 0], [2, 2, 5])
      47.0
  """
  @spec scalar_triple_product([number], [number], [number]) :: number
  def scalar_triple_product(u, v, w) do
    Matrix.det([u, v, w])
  end

  @doc """
  Computes the volume of a parallelepiped.
  ##### Examples
      iex> ExAlgebra.Vector3.volume_of_parallelepiped([-3, 2, 1], [-1, -3, 0], [2, 2, -5])
      51.0
  """
  @spec volume_of_parallelepiped([number], [number], [number]) :: number
  def volume_of_parallelepiped(u, v, w), do: u |> scalar_triple_product(v, w) |> abs

end