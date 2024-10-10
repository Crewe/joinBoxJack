defmodule JoinBoxJackWeb.View do
  use JoinBoxJackWeb, :live_view

  def render(assigns) do
    ~H"""
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event(_event, _unsigned_params, socket) do
    {:noreply, socket}
  end

end
