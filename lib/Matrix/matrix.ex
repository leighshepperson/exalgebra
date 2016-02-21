defmodule ExAlgebra.Matrix do
	alias ExAlgebra.Vector, as: Vector

	def size([first_row | _] = matrix) do
		%{rows: length(matrix), columns: length(first_row)}
	end

	def add([matrix_one_first_row | matrix_one_remaining_rows], [matrix_two_first_row | matrix_two_remaining_rows]) do
		[Vector.add(matrix_one_first_row, matrix_two_first_row) | add(matrix_one_remaining_rows, matrix_two_remaining_rows)]
	end

	def add([], []), do: []

	def subtract([matrix_one_first_row | matrix_one_remaining_rows], [matrix_two_first_row | matrix_two_remaining_rows]) do
		[Vector.subtract(matrix_one_first_row, matrix_two_first_row) | subtract(matrix_one_remaining_rows, matrix_two_remaining_rows)]
	end

	def subtract([], []), do: []

	def scalar_multiply([], _scalar), do: []

	def scalar_multiply(matrix, scalar) do
		matrix |> List.foldl([], &(&2 ++ [Vector.scalar_multiply(&1, scalar)]))
	end

	def transpose(matrix) do
		matrix |> List.zip |> Enum.map(&Tuple.to_list(&1))
	end

	def multiply(matrix_one, matrix_two) do
		naive_multiply(matrix_one, transpose(matrix_two))
	end

	defp naive_multiply(matrix_one, matrix_two) do
		matrix_one |> List.foldl([], fn(row, acc) -> acc ++ [matrix_two |> Enum.map(&Vector.dot(&1, row))] end)
	end

end