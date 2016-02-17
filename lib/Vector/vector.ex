defmodule ExAlgebra.Vector do

	def magnitude(vector) do
		import :math, only: [sqrt: 1]
	 	vector |> sqr_magnitude |> sqrt
	end

	def sqr_magnitude(vector) do
		vector |> List.foldl(0, fn(element, sum_of_squares) -> element * element + sum_of_squares end)
	end

	def normalize(vector) do
		magnitude = magnitude(vector)
		vector |> Enum.map(fn(element) -> element / magnitude end)
	end

end