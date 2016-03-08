defmodule ExAlgebra.Vector3Test do
  use ExUnit.Case, async: true
  doctest ExAlgebra.Vector3

  import ExAlgebra.Vector3

  test "Returns the cross product of two 3-vectors" do
    vector_one = [2, 1, -1]
    vector_two = [-3, 4, 1]

    assert cross_product(vector_one, vector_two) == [5, 1, 11]

    vector_one = [-3, 4, 1]
    vector_two = [2, 1, -1]

    assert cross_product(vector_one, vector_two) == [-5, -1, -11]
  end

  test "Returns true if two 3-vectors are parallel" do
    vector_one = [2, -4, 1]
    vector_two = [-6, 12, -3]

    assert is_parallel?(vector_one, vector_two)
  end

  test "Returns false if two 3-vectors are not parallel" do
    vector_one = [2, -4, 1]
    vector_two = [-6, 12, 3]

    assert !is_parallel?(vector_one, vector_two)
  end

  test "Returns the equation of the plain containing three 3-vector points" do
    vector_one = [1, 3, 0]
    vector_two = [3, 4, -3]
    vector_three = [3, 6, 2]

    assert equation_of_plain(vector_one, vector_two, vector_three) == [11, -10, 4, -19]

    vector_one = [1, -2, 0]
    vector_two = [3, 1, 4]
    vector_three = [0, -1, 2]

    assert equation_of_plain(vector_one, vector_two, vector_three) == [2, -8, 5, 18]
  end

  test "Returns the area of the parallelogram formed by two 3-vectors" do
      vector_one = [2, 1, -3]
      vector_two = [1, 3, 2]

      assert area_of_parallelogram(vector_one, vector_two) == :math.sqrt(195)
   end

  test "Returns the scalar triple product of three 3-vectors" do
      vector_one = [3, 2, 1]
      vector_two = [-1, 3, 0]
      vector_three = [2, 2, 5]

      assert scalar_triple_product(vector_one, vector_two, vector_three) == 47
   end

   test "Returns the volume of the parallelepiped formed by three 3-vectors" do
      vector_one = [-3, 2, 1]
      vector_two = [-1, -3, 0]
      vector_three = [2, 2, -5]

      assert volume_of_parallelepiped(vector_one, vector_two, vector_three) == 51
   end

end