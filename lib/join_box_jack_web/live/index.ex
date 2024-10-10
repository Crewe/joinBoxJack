defmodule JoinBoxJackWeb.Index do
  use JoinBoxJackWeb, :live_view

  alias JoinBoxJack.Generator

  attr :room_status, :string, default: nil
  attr :max_room_code_len, :integer, default: 5
  attr :max_name_len, :integer, default: 12
  attr :remaining_chars, :integer, default: 12
  def render(assigns) do
    ~H"""
    <div class="w6">
      <div class="row hero">
        <h1><b>Let's Play!</b></h1>
        <p>Enter your name and a room code if you have one.</p>
      </div>
      <div class="row">
        <.simple_form for={@form} phx-change="form_change" phx-submit="begin" autocomplete="off">
          <.label for="room_code">
            Room Code
            <span class="status" style="float:right; font-style:italic;color:firebrick;">
              <%= @room_status %>
            </span>
            <.input
              id="room-code"
              name="room_code"
              field={@form[:room_code]}
              maxlength={@max_room_code_len}
              pattern="[a-zA-Z]+"
              value={@form[:room_code]}
              style="text-transform:uppercase;"
              placeholder="CODE"
            />
          </.label>
          <.label for="player_name">
            Name
            <span class="status" style="float:right; font-style:italic;">
              <%= @remaining_chars %>
            </span>
            <.input
              id="creator-name"
              name="player_name"
              field={@form[:player_name]}
              maxlength={@max_name_len}
              pattern="[a-zA-Z]+"
              min={2}
              value={@form[:player_name]}
              placeholder="Player Name"
              required
            />
          </.label>
          <.button type="submit"><%= @btn_text %></.button>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:form, %{})
      |> assign(:btn_text, "Start a Game")
    {:ok, socket}
  end

  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("begin", %{"room_code" => room_code}, socket) do
    if String.length(room_code) == 5 do
      socket = push_navigate(socket, to: ~p"/lobby/#{room_code}")
      {:noreply, socket}
    else
      socket = push_navigate(socket, to: ~p"/lobby/#{Generator.reserve_room_code()}")
      {:noreply, socket}
    end
  end
end
