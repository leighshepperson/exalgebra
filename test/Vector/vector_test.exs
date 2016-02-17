defmodule ExAlgebra.VectorTest do
	use ExUnit.Case
	import ExAlgebra.Vector
	@precision 10

	test "Returns the magnitude of a vector" do
		input = [1, 2, 3, 4]
		expected = 5.4772255751
		assert approximate_evaluation(magnitude(input)) == expected
	end

	defp approximate_evaluation(function_to_evaluate) do
		function_to_evaluate |> approximate_evaluation(@precision)
	end

	defp approximate_evaluation(function_to_evaluate, precision) do
		function_to_evaluate |> Float.round(precision)
	end

end