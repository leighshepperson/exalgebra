defmodule ExAlgebra.MatrixTest do
  use ExUnit.Case, async: true
  doctest ExAlgebra.Matrix
  import ExAlgebra.Matrix

  test "Returns the rank of a 1 x 1 matrix" do
    input = [[3]]
    expected = %{rows: 1, columns: 1}
    assert rank(input) == expected
  end

  test "Returns the rank of a 3 x 2 matrix" do
    input = [[1, 2], [3, 4], [4, 3]]
    expected = %{rows: 3, columns: 2}
    assert rank(input) == expected
  end

  test "Returns the addition of two 2 x 3 matrices" do
    matrix_one = [[1, 3, 1], [1, 0, 0]]
    matrix_two = [[0, 0, 5], [7, 5, 0]]
    expected = [[1, 3, 6], [8, 5, 0]]

    assert add(matrix_one, matrix_two) == expected
  end

  test "Returns the subtraction of two 2 x 3 matrices" do
    matrix_one = [[1, 3, 1], [1, 0, 0]]
    matrix_two = [[0, 0, 5], [7, 5, 0]]
    expected = [[1, 3, -4], [-6, -5, 0]]

    assert subtract(matrix_one, matrix_two) == expected
  end

  test "Returns the multiplication of a 1 x 1 matrix by a scalar" do
    matrix = [[1]]
    scalar = 2.5
    expected = [[2.5]]

    assert scalar_multiply(matrix, scalar) == expected
  end

  test "Returns the multiplication of a matrix by a scalar" do
    matrix = [[1, 3, 1], [1, 0, 0]]
    scalar = 2.5
    expected = [[2.5, 7.5, 2.5], [2.5, 0, 0]]

    assert scalar_multiply(matrix, scalar) == expected
  end

  test "Returns the transpose of a 1 x 1 matrix" do
    matrix = [[1]]
    expected = [[1]]

    assert transpose(matrix) == expected
  end

  test "Returns the transpose of a 2 x 3 matrix" do
    matrix = [[1, 2, 3], [0, -6, 7]]
    expected = [[1, 0], [2, -6], [3, 7]]

    assert transpose(matrix) == expected

  end

  test "Returns the transpose of a 3 x 2 matrix" do
    matrix = [[1, 0], [2, -6], [3, 7]]
    expected = [[1, 2, 3], [0, -6, 7]]

    assert transpose(matrix) == expected
  end

  test "Returns the multiple of a 1 x 1 matrix by a 1 x 1 matrix" do
    matrix_one = [[1]]
    matrix_two = [[2]]
    expected = [[2]]

    assert multiply(matrix_one, matrix_two) == expected
  end

  test "Returns the multiple of a 2 x 2 matrix by a 2 x 2 matrix" do
    matrix_one = [[1, 2], [3, 4]]
    matrix_two = [[0, 1], [0, 0]]
    expected = [[0, 1], [0, 3]]

    assert multiply(matrix_one, matrix_two) == expected
  end

  test "Returns the multiple of a 2 x 3 matrix by a 3 x 2 matrix" do
    matrix_one = [[2, 3, 4], [1, 0, 0]]
    matrix_two = [[0, 1000], [1, 100], [0, 10]]
    expected = [[3, 2340], [0, 1000]]

    assert multiply(matrix_one, matrix_two) == expected
  end

  test "Returns the multiple of a 3 x 5 matrix by a 5 x 5 matrix" do
    matrix_one = [[1, 2, 3, 3, 1], [4, 5, 5, 3, 3], [6, 7, 8, 1, 1]]
    matrix_two = [[3, 4, 5, 3, 3], [2, 4, -7, 3, 3], [4, 5, 7, 1, 4], [4, 3, 2, 1, 1], [3, 1, 2, 3, 4]]
    expected = [[34, 37, 20, 18, 28], [63, 73, 32, 44, 62], [71, 96, 41, 51, 76]]

    assert multiply(matrix_one, matrix_two) == expected
  end
  
  test "Removes the ith row of a matrix" do
    matrix =  [[2, 3, 4], [1, 0, 0], [3, 4, 5]]
    
    assert remove_row(matrix, 1) == [[1, 0, 0], [3, 4, 5]]
    assert remove_row(matrix, 2) == [[2, 3, 4], [3, 4, 5]]
    assert remove_row(matrix, 3) == [[2, 3, 4], [1, 0, 0]]
  end

  test "Removes the ith column of a matrix" do
    matrix =  [[2, 3, 4], [1, 0, 0], [3, 4, 5]]
    
    assert remove_column(matrix, 1) == [[3, 4], [0, 0], [4, 5]]
    assert remove_column(matrix, 2) == [[2, 4], [1, 0], [3, 5]]
    assert remove_column(matrix, 3) == [[2, 3], [1, 0], [3, 4]]
  end

  test "Returns the (i, j) submatrix of a 3 x 3 matrix" do
    matrix =  [[2, 3, 4], [1, 0, 0], [3, 4, 5]]

    assert submatrix(matrix, 1, 1) == [[0, 0], [4, 5]]
    assert submatrix(matrix, 1, 2) == [[1, 0], [3, 5]]
    assert submatrix(matrix, 1, 3) == [[1, 0], [3, 4]]
    assert submatrix(matrix, 2, 3) == [[2, 3], [3, 4]]
    assert submatrix(matrix, 3, 3) == [[2, 3], [1, 0]]
  end

  test "Returns the (i, j) minor of a 3 x 3 matrix" do
    matrix =  [[2, 3, 4], [1, 0, 0], [3, 4, 5]]

    assert minor(matrix, 1, 1) == 0
    assert minor(matrix, 1, 2) == 5
    assert minor(matrix, 1, 3) == 4
    assert minor(matrix, 2, 3) == -1
    assert minor(matrix, 3, 3) == -3
  end

  test "Returns the (i, j) cofactor of a 3 x 3 matrix" do
    matrix =  [[2, 3, 4], [1, 0, 0], [3, 4, 5]]

    assert cofactor(matrix, 1, 1) == 0
    assert cofactor(matrix, 1, 2) == -5
    assert cofactor(matrix, 1, 3) == 4
    assert cofactor(matrix, 2, 3) == 1
    assert cofactor(matrix, 3, 3) == -3
  end

  test "Computes the determinant of a 2 x 2 matrix" do
    matrix = [[1, 2], [3, 4]]
    expected = -2

    assert det(matrix) == expected
  end

  test "Computes the determinant of a 3 x 3 matrix" do
    matrix =  [[6, 1, 1], [4, -2, 5], [2, 8, 7]]

    assert det(matrix) == -306
  end

  test "Computes the determinant of a 5 x 5 matrix" do
    matrix =  [[5, 2, 0, 0, -2], [0, 1, 4, 3, 2], [0, 0, 2, 6, 3], [0, 0, 3, 4, 1], [0, 0, 0, 0, 2]]

    assert det(matrix) == -100
  end

  test "Returns the trace of a 1 x 1 matrix" do
    matrix = [[1]]
    expected = 1
    assert trace(matrix) == expected
  end

  test "Returns the trace of a 3 x 3 matrix" do
    matrix = [[6, 1, 1], [4, -2, 5], [2, 8, 7]]

    expected = 11
    assert trace(matrix) == expected
  end

  test "Generates a 3 x 3 matrix given a generator function that adds the indices" do
    generator_function = fn(i, j) -> i + j end
    expected = [[2, 3, 4], [3, 4, 5], [4, 5, 6]]

    assert generate_matrix(generator_function, 3, 3) == expected
  end

  test "Generates a 1 x 1 matrix given a generator function that multiplies the indices" do
    generator_function = fn(i, j) -> i * j end
    expected = [[1]]

    assert generate_matrix(generator_function, 1, 1) == expected
  end

  test "Generates a 4 x 3 matrix given a generator function that multiplies the indices" do
    generator_function = fn(i, j) -> i * j end
    expected = [[1, 2, 3], [2, 4, 6], [3, 6, 9], [4, 8, 12]]

    assert generate_matrix(generator_function, 4, 3) == expected
  end

  test "Computes the LU decomposition of a 3 x 3 matrix" do
    input = [[1, 2, 4], [3, 8, 14], [2, 6, 13]]

    expected = %{l: [[1,0,0], [3, 1, 0], [2, 1, 1]], u: [[1, 2, 4], [0, 2, 2], [0, 0, 3]]}

    assert lu_decomposition(input) == expected 

    input = [[3, 1, 6], [-6, 0, -16], [0, 8, -17]]

    expected = %{l: [[1,0,0], [-2, 1, 0], [0, 4, 1]], u: [[3, 1, 6], [0, 2, -4], [0, 0, -1]]}

    assert lu_decomposition(input) == expected

    input = [[1, 1, -2], [1, 3, -1], [1, 5, 1]]

  end

  test "If the matrix contains a small value on the pivot row, then the LU decomposition succeeds" do
    input = [[0.0001, 1], [1, 1]]

    expected = %{l: [[1,0], [0.0001, 1]], u: [[1, 1], [0, 0.9999]]}

    assert lu_decomposition(input) == expected

    input = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    expected = [32]

    assert lu_decomposition(input) == expected

  end

end