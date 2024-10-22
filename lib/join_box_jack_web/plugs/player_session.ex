defmodule JoinBoxJackWeb.Plugs.PlayerSession do
  import Plug.Conn

  alias JoinBoxJack.Generator

  def init(default), do: default

  @doc """
  If the player doesn't have a session ID generate one
  """
  def call(conn, _default) do
    # Debug: Nukes the session
    # conn = configure_session(conn, drop: true)
    case get_session(conn, :player_id) do
      nil ->
        %{id: id} = Generator.gen_user_id()
        put_session(conn, :player_id, id)

      _ ->
        conn
    end
  end
end
