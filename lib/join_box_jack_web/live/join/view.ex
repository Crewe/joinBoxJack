defmodule JoinBoxJackWeb.Join.View do
  use JoinBoxJackWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1>Hello <%= @player_name %>!</h1>
    <p><em>Welcome to room <%= @room_code %></em></p>
    """
  end

  def mount(params, _session, socket) do
    socket =
      socket
      |> assign(:room_code, params["room_code"])
      |> assign(:player_name, params["player_name"])

    {:ok, socket}
  end

  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event(_event, _unsigned_params, socket) do
    {:noreply, socket}
  end
end
