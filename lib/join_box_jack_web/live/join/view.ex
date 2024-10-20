defmodule JoinBoxJackWeb.Join.View do
  use JoinBoxJackWeb, :live_view

  alias JoinBoxJack.Generator

  def render(assigns) do
    ~H"""
    <h1>Hello @player.name !</h1>
    <p><em>Welcome to room <%= @room_code %></em></p>
    <hr />
    <table id="player-lobby" class="table-fixed boder-separate border-spacing-2">
      <thead>
        <tr>
          <td>Players</td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Player Name 1</td>
        </tr>
        <tr>
          <td>Player Name 2</td>
        </tr>
        <tr>
          <td>Player Name 3</td>
        </tr>
        <tr>
          <td>Player Name 4</td>
        </tr>
        <tr>
          <td>Player Name 5</td>
        </tr>
        <tr>
          <td>Player Name 6</td>
        </tr>
        <tr>
          <td>Player Name 7</td>
        </tr>
        <tr>
          <td>Player Name 8</td>
        </tr>
        <tr>
          <td>Player Name 9</td>
        </tr>
        <tr>
          <td>Player Name 10</td>
        </tr>
      </tbody>
    </table>
    """
  end

  def mount(%{"room_code" => room_code}, _session, socket) do
    socket =
      socket
      |> assign(:room_code, room_code)
      |> assign(:player_name, "[Get Sesh Name]")

    {:ok, socket}
  end

  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event(_event, _unsigned_params, socket) do
    {:noreply, socket}
  end

  def add_player([], player) do
    [1, player.name]
  end

  def add_player([head | tail], player) do
    if head < 10 do
      lst = [player | tail]
      {:ok, [head + 1 | lst]}
    else
      {:error, "Room is full"}
    end
  end

  defp get_player_id(session, name) do
    player = Generator.gen_user_id(name)
  end
end
