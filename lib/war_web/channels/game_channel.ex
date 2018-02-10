defmodule WarWeb.GameChannel do
  use WarWeb, :channel
  alias WarWeb.Presence
  alias War.GamePlay.GamePlay

  def join("games:" <> game_id, _payload, socket) do
    user_id = socket.assigns.current_user
    

    {:ok, "Joined games:#{game_id}", socket}
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end




end