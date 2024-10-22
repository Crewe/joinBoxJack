defmodule JoinBoxJack.Redis do
  defp connect() do
    config = Application.get_env(:join_box_jack, JoinBoxJack.Redis)
    {:ok, conn} = Redix.start_link(host: config[:ip], port: config[:port])
    conn
  end

  @doc """
  Check to see if a key exists
  """
  def exists(key) do
    Redix.command(connect(), ["EXISTS", key])
  end

  @doc """
  Create a hast set
  """
  def hset(list) do
    Redix.command(connect(), ["HSET" | list])
  end

  @doc """
  Get all values in a hash set
  """
  def hgetall(hset_id) do
    Redix.command(connect(), ["HGETALL", "#{hset_id}"])
  end

  @doc """
  Simple set
  """
  def set(key, val) do
    Redix.command(connect(), ["SET", key, val])
  end

  @doc """
  Simple get
  """
  def get(key) do
    Redix.command(connect(), ["GET", key])
  end
end
