defmodule ExAlgebra.Vector do
	import :math, only: [sqrt: 1]

	def magnitude(vector) do
	   vector 
	   |> List.foldl(0, fn(element, sum_of_squares) -> element * element + sum_of_squares end)
	   |> sqrt
	end

	def normalize(vector) do
		magnitude = magnitude(vector)
		vector |> Enum.map(fn(element) -> element / magnitude end)
	end

end