defmodule JoinBoxJack.Generator do
  @doc """
  Generates an alphabetical room code of n-length
  """
  def gen_room_code(n \\ 5) do
    Enum.map(1..n, fn _ -> Enum.random(97..122) end)
    |> to_string()
    |> String.upcase()
    |> check_code(n)
  end

  defp check_code(code, len) do
    if String.contains?(code, ["A", "E", "I", "O", "U"]),
      do: gen_room_code(len) |> check_code(len),
      else: code
  end
end
