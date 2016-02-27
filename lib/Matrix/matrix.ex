defmodule ExAlgebra.Matrix do
  @moduledoc """
  Functions that operate on matrices. 

  Matrices are represented as lists of lists of numbers `[[number]]`. 

  Rows are represented by the inner lists.

  Columns are represented by the elements of the inner lists. 
  """
  
  import :math, only: [pow: 2]
  alias ExAlgebra.Vector, as: Vector

  @doc """
  Computes the rank of a matrix. Both the row rank and the column rank are
  returned as a map. 
  ##### Examples
      iex> ExAlgebra.Matrix.rank([[1, 2], [3, 4], [4, 3]])
      %{rows: 3, columns: 2}
  """
  @spec rank([[number]]) :: map
  def rank([first_row | _] = matrix) do
    %{rows: length(matrix), columns: length(first_row)}
  end

  @doc """
  Computes the addition of two matrices. This is a new matrix with entries equal 
  to the sum of the pair of matrices's corresponding entries. 
  The input matrices should have the same rank.
  ##### Examples
      iex> ExAlgebra.Matrix.add([[1, 3, 1], [1, 0, 0]], [[0, 0, 5], [7, 5, 0]])
      [[1, 3, 6], [8, 5, 0]]
  """
  @spec add([[number]], [[number]]) :: [[number]]
  def add([], []), do: []
  def add([a_first_row | a_remaining_rows], [b_first_row | b_remaining_rows]) do
    [Vector.add(a_first_row, b_first_row) | add(a_remaining_rows, b_remaining_rows)]
  end

  @doc """
  Computes the subtraction of two matrices. This is a new matrix with entries 
  equal to the difference of the pair of matrices's corresponding entries.   
  The input matrices should have the same rank.
  ##### Examples
      iex> ExAlgebra.Matrix.subtract([[1, 3, 1], [1, 0, 0]], [[0, 0, 5], [7, 5, 0]])
      [[1, 3, -4], [-6, -5, 0]]
  """
  @spec subtract([[number]], [[number]]) :: [[number]]
  def subtract([], []), do: []
  def subtract([a_first_row | a_remaining_rows], [b_first_row | b_remaining_rows]) do
    [Vector.subtract(a_first_row, b_first_row) | subtract(a_remaining_rows, b_remaining_rows)]
  end

  @doc """
  Computes the multiple of a matrix by a scalar value.
  ##### Examples
      iex> ExAlgebra.Matrix.scalar_multiply([[1, 3, 1], [1, 0, 0]] , 2.5)
      [[2.5, 7.5, 2.5], [2.5, 0.0, 0.0]]
  """
  @spec scalar_multiply([[number]], number) :: [[number]]
  def scalar_multiply([], _scalar), do: []
  def scalar_multiply(matrix, scalar) do
    matrix |> Enum.map(&Vector.scalar_multiply(&1, scalar))
  end

  @doc """
  Computes the transpose of a matrix. This is the matrix A<sup>t</sup> built 
  from the matrix A where the entries A<sub>ij</sub> have been mapped 
  to A<sub>ji</sub>.
  ##### Examples
      iex> ExAlgebra.Matrix.transpose([[1, 3, 1], [1, 0, 0]])
      [[1, 1], [3, 0], [1, 0]]
  """
  @spec transpose([[number]]) :: [[number]]
  def transpose(matrix) do
    matrix |> List.zip |> Enum.map(&Tuple.to_list(&1))
  end

  @doc """
  Computes the multiplication of two matrices. If the rank of matrix A is 
  `n x m`, then the rank of matrix B must be `m x n`.
  ##### Examples
      iex> ExAlgebra.Matrix.multiply([[2, 3, 4], [1, 0, 0]], [[0, 1000], [1, 100], [0, 10]])
      [[3, 2340], [0, 1000]]
  """
  @spec multiply([[number]], [[number]]) :: [[number]]
  def multiply(a, b) do
    naive_multiply(a, transpose(b))
  end

  @doc """
  Returns the `(i, j)` submatrix of a matrix. This is the matrix with the 
  i<sup>th</sup> row and j<sup>th</sup> column removed.
  ##### Examples
      iex> ExAlgebra.Matrix.submatrix([[2, 3, 4], [1, 0, 0], [3, 4, 5]], 2, 3)
      [[2, 3], [3, 4]]
  """
  @spec submatrix([[number]], number, number) :: [[number]]
  def submatrix(matrix, i, j) do
    matrix |> remove_row(i) |> remove_column(j) 
  end

  @doc """
  Removes the j<sup>th</sup> column of a matrix.
  ##### Examples
      iex> ExAlgebra.Matrix.remove_column([[2, 3, 4], [1, 0, 0], [3, 4, 5]], 2)
      [[2, 4], [1, 0], [3, 5]]
  """
  @spec remove_column([[number]], number) :: [[number]]
  def remove_column(matrix, j) do
    matrix |> Enum.map(&(List.delete_at(&1, j - 1)))
  end

  @doc """
  Removes the i<sup>th</sup> row of a matrix.
  ##### Examples
      iex> ExAlgebra.Matrix.remove_row([[2, 3, 4], [1, 0, 0], [3, 4, 5]], 2)
      [[2, 3, 4], [3, 4, 5]]
  """
  @spec remove_row([[number]], number) :: [[number]]
  def remove_row(matrix, i) do
    matrix |> List.delete_at(i - 1)
  end

  @doc """
  Computes the determinant of a matrix. This is computed by summing the cofactors 
  of the matrix multiplied by corresponding elements of the first row.
  ##### Examples
      iex> ExAlgebra.Matrix.det([[6, 1, 1], [4, -2, 5], [2, 8, 7]])
      -306.0
  """
  @spec det([[number]]) :: number
  def det([[a]]), do: a 
  def det([first_row | _] = matrix) do
    first_row 
    |> Enum.with_index 
    |> List.foldl(0, fn({row_element, row_index}, acc) -> acc +  row_element * cofactor(matrix, 1, row_index + 1) end)
  end

  @doc """
  Computes the `(i, j)` cofactor of a matrix. This is equal to the `(i, j)` minor 
  of a matrix multiplied by `-1` raised to the power of `i + j`.
  ##### Examples
      iex> ExAlgebra.Matrix.cofactor( [[2, 3, 4], [1, 0, 0], [3, 4, 5]], 1, 2)
      -5.0
  """
  @spec cofactor([[number]], number, number) :: number
  def cofactor(matrix, i, j), do: minor(matrix, i, j) * pow(-1, i + j)

  @doc """
  Computes the `(i, j)` minor of a matrix. This is the determinant of a matrix 
  whose i<sup>th</sup> row and j<sup>th</sup> column have been removed.
  ##### Examples
      iex> ExAlgebra.Matrix.minor( [[2, 3, 4], [1, 0, 0], [3, 4, 5]], 1, 2)
      5.0
  """
  @spec minor([[number]], number, number) :: number
  def minor(matrix, i, j), do: matrix |> submatrix(i, j) |> det

  @doc """
  Computes the the trace of a matrix. This is the sum of the elements down the 
  diagonal of a matrix.
  ##### Examples
      iex> ExAlgebra.Matrix.trace([[6, 1, 1], [4, -2, 5], [2, 8, 7]])
      11
  """
  @spec trace([[number]]) :: number
  def trace(matrix) do
    matrix |> Enum.with_index |> Enum.map(fn({row, index}) -> Enum.at(row, index) end) |> Enum.sum
  end

  @doc """
  Generates a matrix based on a generator function that depends on the position of the matrix element. 
  ##### Examples
      iex> ExAlgebra.Matrix.generate_matrix(fn(i, j) -> i + j end, 3, 3)
      [[2, 3, 4], [3, 4, 5], [4, 5, 6]]

      iex> ExAlgebra.Matrix.generate_matrix(fn(i, j) -> i * j end, 4, 3)
      [[1, 2, 3], [2, 4, 6], [3, 6, 9], [4, 8, 12]]
  """
  @spec generate_matrix(((number, number) -> number), number, number) :: [[number]]
  def generate_matrix(_generator_fun, number_of_rows, _number_of_columns) when number_of_rows == 0, do: []
  def generate_matrix(generator_fun, number_of_rows, number_of_columns) do
    generate_matrix(generator_fun, number_of_rows - 1, number_of_columns) ++ [generate_row(generator_fun, number_of_rows, number_of_columns)]
  end

  @spec lu_decomposition([[number]]) :: map
  def lu_decomposition([[h | t] | remaining_rows] = matrix) do
  m = [{[[h | t]], [[1.0]] ++ transform_column(remaining_rows, h)} | lu_decomposition(subtract(submatrix(matrix, 1, 1), transform_column(remaining_rows, h) |> multiply [t]), 1)]
  
  IO.inspect(h(m))
  IO.inspect(transpose(h(m)))
  %{u: g(m), l: transpose(h(m))}

  end

  def g([]), do: []
  def g([{a, b} | remaining_rows]) do
    a ++ g(remaining_rows)
  end


  def h([]), do: []
  def h([{a, b} | remaining_rows]) do
     Enum.into([b],  h(remaining_rows))
  end

   def lu_decomposition([[h | t] | remaining_rows] = matrix, append) do
   ta =  for n <- 0..(append - 1), do: 0
   tal = for n <- 0..(append - 1), do: [0.0] 
   tal = tal ++ [[1.0]]

   [{  [ta ++ [h | t]], tal ++ transform_column(remaining_rows, h) } | lu_decomposition(subtract(submatrix(matrix, 1, 1), transform_column(remaining_rows, h) |> multiply [t]), append + 1)]
  end

  def lu_decomposition([], _append), do: []

  def transform_column([[h1 | _] | _ = remaining_rows], h) do

    [[h1 / h] | transform_column(remaining_rows, h)]
  end
 def transform_column([], _) do
[]
 end

  @spec generate_row(((number, number) -> number), number, number) :: [number]
  defp generate_row(_generator_fun, _row_index, 0), do: []
  defp generate_row(generator_fun, row_index, number_of_columns) do
    generate_row(generator_fun, row_index, number_of_columns - 1) ++ [generator_fun.(row_index, number_of_columns)]
  end

  @spec naive_multiply([[number]], [[number]]) :: [[number]]
  defp naive_multiply(matrix_one, matrix_two) do
    matrix_one |> List.foldl([], fn(row, acc) -> acc ++ [matrix_two |> Enum.map(&Vector.dot(&1, row))] end)
  end

end