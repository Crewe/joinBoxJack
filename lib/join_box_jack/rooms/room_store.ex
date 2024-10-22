# TODO: Refactor 'lobby' and 'room' to 'clubhouse'
defmodule JoinBoxJack.Rooms.RoomStore do
  alias JoinBoxJack.Redis

  def exists?(ch_id) do
    case Redis.exists(ch_id) do
      {:ok, 0} -> false
      {:ok, _val} -> true
      _ -> false
    end
  end

  def add(ch_id) do
    Redis.set(ch_id, nil)
  end
end
