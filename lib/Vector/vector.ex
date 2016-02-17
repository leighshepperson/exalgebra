defmodule ExAlgebra.Vector do
	import :math, only: [sqrt: 1]

	def magnitude(vector) do
	   vector 
	   |> List.foldl(0, fn (x, acc) -> x * x + acc end)
	   |> sqrt
	end

end