defmodule JoinBoxJackWeb.Plugs.PlayerSession do
  import Plug.Conn

  alias JoinBoxJack.Players.PlayerStore

  def init(default), do: default

  @doc """
  If the player doesn't have a session ID generate one
  """
  def call(conn, _default) do
    # Debug: Nukes the session
    # conn = configure_session(conn, drop: true)
    case get_session(conn, :player_id) do
      nil ->
        put_session(conn, :player_id, PlayerStore.gen_user_id())

      _ ->
        conn
    end
  end
end
