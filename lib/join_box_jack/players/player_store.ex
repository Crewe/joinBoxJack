defmodule JoinBoxJack.Players.PlayerStore do
  alias JoinBoxJack.Redis
  alias JoinBoxJack.Players.Player

  @doc """
  Generate an ID for a player. (With collision check)
  """
  def gen_user_id() do
    new_id = UUID.uuid1(:hex)
    if exists?(new_id), do: gen_user_id(), else: new_id
  end

  @doc """
  Check if the player exists.

  _faster than getting the player_
  """
  def exists?(player_id) do
    case Redis.exists("player:#{player_id}") do
      {:ok, 0} -> false
      {:ok, _val} -> true
      _ -> false
    end
  end

  @doc """
  Retrieve a player from the DB
  """
  def get_player(player_id) do
    case Redis.hgetall("player:#{player_id}") do
      {:ok, []} ->
        {:miss, "No player data"}

      {:ok, player_data} ->
        {:ok, rezip_hset(player_data) |> map_to_player()}
    end
  end

  @doc """
  Add or update a ployer in the DB
  """
  def put_player(%Player{} = player) do
    lst = ["name", player.name]
    lst = ["id", player.id | lst]
    # prepend the set identifier and command
    lst = ["player:#{player.id}" | lst]

    case Redis.hset(lst) do
      {:ok, 2} -> {:ok, :created}
      {:ok, 0} -> {:ok, :updated}
      _ -> {:error, "Failed to put player record"}
    end
  end

  defp rezip_hset(hset) do
    side_a = for {k, v} <- Enum.with_index(hset), rem(v, 2) == 0, do: String.to_atom(k)
    side_b = for {k, v} <- Enum.with_index(hset), rem(v, 2) != 0, do: k
    Enum.zip(side_a, side_b) |> Enum.into(%{})
  end

  defp map_to_player(player_map), do: struct(Player, player_map)

end
