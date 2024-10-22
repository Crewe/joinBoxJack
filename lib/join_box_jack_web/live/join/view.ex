defmodule JoinBoxJackWeb.Join.View do
  use JoinBoxJackWeb, :live_view

  alias JoinBoxJack.Players.PlayerStore

  def render(assigns) do
    ~H"""
    <p>Hello <%= @player_name %>!
      Your room code is: <em><%= @room_code %></em></p>
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

  def mount(%{"room_code" => room_code}, %{"player_id" => player_id} = _session, socket) do
    case PlayerStore.get_player(player_id) do
      {:ok, player} ->
        socket =
          socket
          |> assign(:room_code, room_code)
          |> assign(:player_id, player.id)
          |> assign(:player_name, player.name)

        {:ok, socket}

      {:miss, _} ->
        socket =
          socket
          |> put_flash(:error, "Player data not found")
          |> redirect(to: ~p"/")

        {:ok, socket}
    end
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
end
