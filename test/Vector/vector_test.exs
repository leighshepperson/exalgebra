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
		expected = 30
		assert sqr_magnitude(input) == expected
	end

	test "Returns the dot product of two vectors" do
		vector_one = [1, 2, 3]
		vector_two = [4, 5, 6]
		expected = 32
		assert dot(vector_one, vector_two) == expected
	end

	test "Returns the sum of two vectors" do
		vector_one = [1, 2, 3]
		vector_two = [4, 5, 6]
		expected = [5, 7, 9]
		assert add(vector_one, vector_two) == expected
	end

	test "Returns the difference of two vectors" do
		vector_one = [1, 2, 3]
		vector_two = [4, 5, 6]
		expected = [-3, -3, -3]
		assert subtract(vector_one, vector_two) == expected
	end

	test "Returns the multiple of a vector and a scalar" do
		vector = [1, 2, 3]
		scalar = 2.5
		expected = [2.5, 5, 7.5]
		assert scalar_multiply(vector, scalar) == expected
	end

	test "Returns the distance between two vectors" do
		vector_one = [1, 2, 3]
		vector_two = [4, 5, 6]
		expected = 5.1961524227
		assert approximate_evaluation(distance(vector_one, vector_two)) == expected
	end

	test "Returns true if two vectors are orthogonal" do
		vector_one = [1, 1, 1]
		vector_two = [-2, 1, 1]
		assert is_orthogonal?(vector_one, vector_two)
	end

	test "Returns false if two vectors are not orthogonal" do
		vector_one = [1, 2, 1]
		vector_two = [-2, 1, 1]
		assert !is_orthogonal?(vector_one, vector_two)
	end

	test "Returns the projection of vector_one on vector_two" do
		vector_one = [1, 2, 4, 0]
		vector_two = [0, 1, 1, 0]
		expected = [2/7, 4/7, 8/7, 0]
		assert approximate_evaluation(project(vector_one, vector_two)) == approximate_evaluation(expected)
	end

	test "Creates an orthogonal vector from a vector and a set of linearly independent orthogonal vectors" do
		vector =  [0, 1, 1, 0]
		vectors = [[1, 2, 4, 0]]
		expected = [-2/7, 3/7, -1/7, 0]
		assert approximate_evaluation(create_orthogonal_vector(vector, vectors)) == approximate_evaluation(expected)
	end

	test "Returns an orthogonal basis of a set of linearly independent vectors" do
		vectors = [[1, 2, 4, 0], [0, 1, 1, 0], [0, 3, 1, 4]]
		expected = [[1, 2, 4, 0], [-2/7, 3/7, -1/7, 0], [2/3, 1/3, -1/3, 4]]
		assert approximate_evaluation(create_orthogonal_basis(vectors)) == approximate_evaluation(expected)
	end

	test "Returns an orthonormal basis from a set of linearly independent vectors" do	
		vectors = [[1, 1, 1], [2, 1, 0], [5, 1, 3]]
		expected = [[0.57735026919, 0.57735026919, 0.57735026919], [0.70710678118, 0, -0.70710678118], [0.40824829046, -0.81649658092, 0.40824829046]]
		assert approximate_evaluation(create_orthonormal_basis(vectors)) == approximate_evaluation(expected)
	end

	test "Retrns true if a set of vectors are linearly independent" do
		vectors = [[1, 1, 1], [2, 1, 0], [5, 1, 3]]
		assert is_linearly_independent?(vectors)
	end

	test "Retrns false if a set of vectors are linearly dependent" do
		vectors = [[2, 3, 5], [-1, -4, -10], [1, -2, -8]]
		assert !is_linearly_independent?(vectors)
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
		function_to_evaluate * 1.0 |> Float.round(precision)
	end

end