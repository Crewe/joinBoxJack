defmodule JoinBoxJack.GeneratorTest do
  use ExUnit.Case
  alias JoinBoxJack.Generator

  test "test code gen outputs code of proper length" do
    assert 5 == String.length(Generator.gen_room_code(5))
    assert 10 == String.length(Generator.gen_room_code(10))
    assert 15 == String.length(Generator.gen_room_code(15))
  end

  test "codes don't contain vowels" do
    for _ <- 1..5,
        do: assert(!String.contains?(Generator.gen_room_code(20), ["A", "E", "I", "O", "U"]))
  end
end
