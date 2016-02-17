defmodule ExAlgebra.Vector do

	def magnitude(vector) do
		import :math, only: [sqrt: 1]
	 	vector |> sqr_magnitude |> sqrt
	end

	def sqr_magnitude(vector) do
		vector |> dot(vector)
	end

	def normalize(vector) do
		magnitude = magnitude(vector)
		vector |> Enum.map(fn(element) -> element / magnitude end)
	end

	def dot([], []), do: 0

	def dot([vector_one_head | vector_one_tail], [vector_two_head | vector_two_tail]) do
		vector_one_head * vector_two_head + dot(vector_one_tail, vector_two_tail)
	end

end