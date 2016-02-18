defmodule ExAlgebra.Vector do
	import :math, only: [sqrt: 1]

	def magnitude(vector), do: vector |> sqr_magnitude |> sqrt

	def sqr_magnitude(vector), do: vector |> dot(vector)

	def normalize(vector), do: vector |> multiply(1 / magnitude(vector))
	
	def dot([], []), do: 0

	def dot([vector_one_head | vector_one_tail], [vector_two_head | vector_two_tail]) do
		vector_one_head * vector_two_head + dot(vector_one_tail, vector_two_tail)
	end

	def add([], []), do: []

	def add([vector_one_head | vector_one_tail], [vector_two_head | vector_two_tail]) do
		[vector_one_head + vector_two_head | add(vector_one_tail, vector_two_tail)]
	end

	def subtract([], []), do: []

	def subtract([vector_one_head | vector_one_tail], [vector_two_head | vector_two_tail]) do
		[vector_one_head - vector_two_head | subtract(vector_one_tail, vector_two_tail)]
	end

	def multiply(vector, scalar) do
		vector |> Enum.map(fn(element) -> element * scalar end)
	end

	def distance(vector_one, vector_two), do: (vector_one |> subtract(vector_two)) |> magnitude 

	def is_orthogonal?(vector_one, vector_two), do: vector_one |> dot(vector_two) == 0
	
	def orthogonal_basis([first_vector | remaining_vectors]) do
		orthogonal_basis(remaining_vectors, [first_vector])
	end

	def orthogonal_basis([], orthogonal_basis), do: orthogonal_basis

	def orthogonal_basis([first_vector | remaining_vectors], orthogonal_vectors) do	
		orthogonal_vectors = orthogonal_vectors ++ [orthogonal_vector(first_vector, orthogonal_vectors)]

		orthogonal_basis(remaining_vectors, orthogonal_vectors)
	end

	def projection(vector_one, vector_two) do
		vector_one |> multiply(dot(vector_one, vector_two) / sqr_magnitude(vector_one))
	end

	def orthogonal_vector(vector, orthogonal_vectors) do
		orthogonal_vectors |> List.foldl(vector, fn(element, acc) -> subtract(acc, projection(element, vector)) end)
	end

	def orthonormal_basis(vectors) do
		vectors |> orthogonal_basis |> Enum.map(&normalize(&1))
	end

end