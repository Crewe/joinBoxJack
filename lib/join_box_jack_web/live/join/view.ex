defmodule JoinBoxJackWeb.Join.View do
  use JoinBoxJackWeb, :live_view

  alias JoinBoxJack.Players.PlayerStore

  def render(assigns) do
    ~H"""
    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
      <!-- <table id="player-lobby" class="table-fixed boder-separate border-spacing-2"> -->
      <table
        id="player-lobby"
        class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400"
      >
        <caption class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
          Your room code: <em><%= @room_code %></em>
          <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">
            Invite others to join with the room code above. Once everybody's in you can organize them into groups.
          </p>
        </caption>
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th scope="col" class="px-6 py-3">Players</th>
            <th scope="col" class="px-6 py-3">Ready</th>
          </tr>
        </thead>
        <tbody>
          <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
            <th
              scope="row"
              class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white"
            >
              <%= @player_name %>
            </th>
            <td class="px-6 py-4">
              Not Ready
            </td>
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
    </div>
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
