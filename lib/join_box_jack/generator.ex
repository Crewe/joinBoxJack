defmodule JoinBoxJack.Generator do
  alias JoinBoxJack.Redis

  @doc """
  Generates an alphabetical room code of n-length
  """
  def gen_room_code(n \\ 5) do
    Enum.map(1..n, fn _ -> Enum.random(97..122) end)
    |> to_string()
    |> String.upcase()
    |> check_code(n)
  end

  @doc """
  Registers a room code in the the redis cache (plug)
  """
  def reserve_room_code() do
    code = gen_room_code()
    if is_code_reserved?(code), do: reserve_room_code()
    {:ok, date} = DateTime.now("Etc/UTC")
    {:ok, _} = Redis.set(code, to_string(date))
    code
  end

  defp check_code(code, len) do
    if String.contains?(code, ["A", "E", "I", "O", "U"]),
      do: gen_room_code(len) |> check_code(len),
      else: code
  end

  defp is_code_reserved?(code) do
    {:ok, r} = Redis.get(String.upcase(code))
    if r == nil, do: false, else: true
  end
end
