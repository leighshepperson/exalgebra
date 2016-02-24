defmodule ExAlgebra.Matrix do
  @moduledoc """
  *ExAlgebra.Matrix* contains functions used in matrix algebra.
  """
  
  import :math, only: [pow: 2]
  alias ExAlgebra.Vector, as: Vector

  @doc """
    Returns the size of a matrix.
    ##### Examples

        iex> matrix = [[1, 2], [3, 4], [4, 3]]
        [[1, 2], [3, 4], [4, 3]]

        iex> matrix |> ExAlgebra.Matrix.size
        %{rows: 3, columns: 2}
  """
  @spec size([[number]]) :: map
  def size([first_row | _] = matrix) do
    %{rows: length(matrix), columns: length(first_row)}
  end

  @doc """
    Returns the addition of two matrices.
    ##### Examples

        iex> matrix = [[1, 3, 1], [1, 0, 0]]
        [[1, 3, 1], [1, 0, 0]]

        iex> matrix |> ExAlgebra.Matrix.add [[0, 0, 5], [7, 5, 0]]
        [[1, 3, 6], [8, 5, 0]]
  """
  @spec add([[number]], [[number]]) :: [[number]]
  def add([h1 | t1], [h2 | t2]) do
    [Vector.add(h1, h2) | add(t1, t2)]
  end
  def add([], []), do: []

  @doc """
    Returns the subtraction of two matrices.
    ##### Examples

        iex> matrix = [[1, 3, 1], [1, 0, 0]]
        [[1, 3, 1], [1, 0, 0]]

        iex> matrix |> ExAlgebra.Matrix.subtract [[0, 0, 5], [7, 5, 0]]
        [[1, 3, -4], [-6, -5, 0]]
  """
  @spec subtract([[number]], [[number]]) :: [[number]]
  def subtract([h1 | t1], [h2 | t2]) do
    [Vector.subtract(h1, h2) | subtract(t1, t2)]
  end
  def subtract([], []), do: []

  @doc """
    Returns the multiple of a matrix by a scalar.
    ##### Examples

        iex> matrix = [[1, 3, 1], [1, 0, 0]]
        [[1, 3, 1], [1, 0, 0]]

        iex> matrix |> ExAlgebra.Matrix.scalar_multiply 2.5
        [[2.5, 7.5, 2.5], [2.5, 0, 0]]
  """
  @spec scalar_multiply([[number]], number) :: [[number]]
  def scalar_multiply([], _scalar), do: []
  def scalar_multiply(matrix, scalar) do
    matrix |> List.foldl([], &(&2 ++ [Vector.scalar_multiply(&1, scalar)]))
  end

  @doc """
    Returns the transpose of a matrix.
    ##### Examples

        iex> matrix = [[1, 3, 1], [1, 0, 0]]
        [[1, 3, 1], [1, 0, 0]]

        iex> matrix |> ExAlgebra.Matrix.transpose
        [[1, 0], [2, -6], [3, 7]]
  """
  @spec transpose([[number]]) :: [[number]]
  def transpose(matrix) do
    matrix |> List.zip |> Enum.map(&Tuple.to_list(&1))
  end

  @doc """
    Returns the multiplication of two matrices.
    ##### Examples

        iex> matrix = [[2, 3, 4], [1, 0, 0]]
        [[2, 3, 4], [1, 0, 0]]

        iex> matrix |> ExAlgebra.Matrix.multiply [[0, 1000], [1, 100], [0, 10]]
        [[3, 2340], [0, 1000]]
  """
  @spec multiply([[number]], [[number]]) :: [[number]]
  def multiply(matrix_one, matrix_two) do
    naive_multiply(matrix_one, transpose(matrix_two))
  end

  @doc """
    Returns the (i, j) submatrix of a 3 x 3 matrix.
    ##### Examples

        iex> matrix = [[2, 3, 4], [1, 0, 0], [3, 4, 5]]
        [[[2, 3, 4], [1, 0, 0], [3, 4, 5]]

        iex> matrix |> ExAlgebra.Matrix.submatrix(2, 3)
        [[2, 3], [3, 4]]
  """
  @spec submatrix([[number]], number, number) :: [[number]]
  def submatrix(matrix, i, j) do
    matrix |> remove_row(i) |> remove_column(j) 
  end

  @doc """
    Removes the ith column of a matrix.
    ##### Examples

        iex> matrix = [[2, 3, 4], [1, 0, 0], [3, 4, 5]]
        [[2, 3, 4], [1, 0, 0], [3, 4, 5]]

        iex> matrix |> ExAlgebra.Matrix.remove_column(2)
        [[2, 4], [1, 0], [3, 5]]
  """
  @spec remove_column([[number]], number) :: [[number]]
  def remove_column(matrix, index) do
    matrix |> Enum.map(&(List.delete_at(&1, index - 1)))
  end

  @doc """
    Removes the ith row of a matrix.
    ##### Examples

        iex> matrix = [[2, 3, 4], [1, 0, 0], [3, 4, 5]]
        [[2, 3, 4], [1, 0, 0], [3, 4, 5]]

        iex> matrix |> ExAlgebra.Matrix.remove_row(2)
        [[2, 3, 4], [3, 4, 5]]
  """
  @spec remove_row([[number]], number) :: [[number]]
  def remove_row(matrix, index) do
    matrix |> List.delete_at(index - 1)
  end

  @doc """
    Returns the determinant of a matrix.
    ##### Examples

        iex> matrix = [[6, 1, 1], [4, -2, 5], [2, 8, 7]]
        [[6, 1, 1], [4, -2, 5], [2, 8, 7]]

        iex> matrix |> ExAlgebra.Matrix.det
        -306
  """
  @spec det([[number]]) :: number
  def det([[a,b], [c,d]]), do: a * d - b * c
  def det([first_row | _] = matrix) do
    first_row 
    |> Enum.with_index 
    |> List.foldl(0, fn({element, index}, acc) -> acc +  element * cofactor(matrix, 1, index + 1) end)
  end

  @doc """
    Returns the (i, j) cofactor of a matrix.
    ##### Examples

        iex> matrix = [[2, 3, 4], [1, 0, 0], [3, 4, 5]]
        [[2, 3, 4], [1, 0, 0], [3, 4, 5]]

        iex> matrix |> ExAlgebra.Matrix.cofactor(1, 2)
        -5
  """
  @spec cofactor([[number]], number, number) :: number
  def cofactor(matrix, i, j), do: minor(matrix, i, j) * pow(-1, i + j)

  @doc """
    Returns the (i, j) minor of a matrix.
    ##### Examples
        iex> matrix = [[2, 3, 4], [1, 0, 0], [3, 4, 5]]
        [[2, 3, 4], [1, 0, 0], [3, 4, 5]]

        iex> matrix |> ExAlgebra.Matrix.minor(1, 2)
        5
  """
  @spec minor([[number]], number, number) :: number
  def minor(matrix, i, j), do: matrix |> submatrix(i, j) |> det

  @doc """
    Returns the trace of a matrix.
    ##### Examples
        iex> matrix = [[6, 1, 1], [4, -2, 5], [2, 8, 7]]
        [[6, 1, 1], [4, -2, 5], [2, 8, 7]]

        iex> matrix |> ExAlgebra.Matrix.trace
        11
  """
  @spec trace([[number]]) :: number
  def trace(matrix) do
    matrix |> Enum.with_index |> Enum.map(fn({row, index}) -> Enum.at(row, index) end) |> Enum.sum
  end

  @spec naive_multiply([[number]], [[number]]) :: [[number]]
  defp naive_multiply(matrix_one, matrix_two) do
    matrix_one |> List.foldl([], fn(row, acc) -> acc ++ [matrix_two |> Enum.map(&Vector.dot(&1, row))] end)
  end

end