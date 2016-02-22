defmodule ExAlgebra.Vector do
	import :math, only: [sqrt: 1]
	alias ExAlgebra.Matrix, as: Matrix

	def add([], []), do: []

	def add([vector_one_head | vector_one_tail], [vector_two_head | vector_two_tail]) do
		[vector_one_head + vector_two_head | add(vector_one_tail, vector_two_tail)]
	end

	def subtract([], []), do: []

	def subtract([vector_one_head | vector_one_tail], [vector_two_head | vector_two_tail]) do
		[vector_one_head - vector_two_head | subtract(vector_one_tail, vector_two_tail)]
	end

	def scalar_multiply(vector, scalar) do
		vector |> Enum.map(&(&1 * scalar))
	end

	def dot([], []), do: 0

	def dot([vector_one_head | vector_one_tail], [vector_two_head | vector_two_tail]) do
		vector_one_head * vector_two_head + dot(vector_one_tail, vector_two_tail)
	end
	
	def magnitude(vector), do: vector |> sqr_magnitude |> sqrt

	def sqr_magnitude(vector), do: vector |> dot(vector)

	def normalize(vector), do: vector |> scalar_multiply(1 / magnitude(vector))

	def distance(vector_one, vector_two), do: (vector_one |> subtract(vector_two)) |> magnitude 

	def is_orthogonal?(vector_one, vector_two), do: vector_one |> dot(vector_two) == 0

	def project(vector_one, vector_two) do
		vector_one |> scalar_multiply(dot(vector_one, vector_two) / dot(vector_one, vector_one))
	end

	def create_orthogonal_vector(vector, linearly_independent_vectors) do
		linearly_independent_vectors |> List.foldl(vector, &subtract(&2, project(&1, &2)))
	end
	
	def create_orthogonal_basis([first_vector | remaining_vectors] = _linearly_independent_vectors) do
	    remaining_vectors |> List.foldl([first_vector], &(&2 ++ [create_orthogonal_vector(&1, &2)]))
	end

	def create_orthonormal_basis(linearly_independent_vectors) do
		linearly_independent_vectors |> create_orthogonal_basis |> Enum.map(&normalize(&1))
	end

	def is_linearly_independent?(vectors), do: Matrix.det(vectors) != 0

end