defmodule ExAlgebra.VectorTest do
	use ExUnit.Case
	import ExAlgebra.Vector
	@precision 10

	test "Returns the magnitude of a vector" do
		input = [1, 2, 3, 4]
		expected = 5.4772255751
		assert approximate_evaluation(magnitude(input)) == expected
	end

	test "Returns the normalized vector" do
		input = [1, 2, 3, 4]
		expected = [0.1825741858, 0.3651483717, 0.5477225575, 0.7302967433]
		assert approximate_evaluation(normalize(input)) == expected
	end

	test "Returns the square magnitude of a vector" do
		input = [1, 2, 3, 4]
		expected = [1, 4, 9, 16]
		assert sqr_magnitude(input) == expected
	end

	defp approximate_evaluation([h|t]) do
		[approximate_evaluation(h) | approximate_evaluation(t)]
	end

	defp approximate_evaluation(function_to_evaluate) do
		function_to_evaluate |> approximate_evaluation(@precision)
	end

	defp approximate_evaluation([], _), do: []

	defp approximate_evaluation([h|t], precision) do
		[approximate_evaluation(h, precision) | approximate_evaluation(t, precision)]
	end

	defp approximate_evaluation(function_to_evaluate, precision) do
		function_to_evaluate |> Float.round(precision)
	end

end