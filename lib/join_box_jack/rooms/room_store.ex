defmodule JoinBoxJack.Rooms.RoomStore do
  alias JoinBoxJack.Redis
  alias JoinBoxJack.Generator

  def exists?(code) do
    case Redis.exists(String.upcase(code)) do
      {:ok, 0} -> false
      {:ok, 1} -> true
      _ -> false
    end
  end

  @doc """
  Registers a room code in the the redis cache (plug)
  """
  def reserve_room_code() do
    code = Generator.gen_room_code()
    if exists?(code), do: reserve_room_code()
    {:ok, date} = DateTime.now("Etc/UTC")
    {:ok, _} = Redis.set(code, to_string(date))
    code
  end
end
