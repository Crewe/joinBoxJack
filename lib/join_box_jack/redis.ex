defmodule JoinBoxJack.Redis do

  defp connect() do
    config = Application.get_env(:join_box_jack, JoinBoxJack.Redis)
    {:ok, conn} = Redix.start_link(host: config[:ip], port: config[:port])
    conn
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
