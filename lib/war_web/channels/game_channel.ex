defmodule WarWeb.GameChannel do
  use WarWeb, :channel
  alias WarWeb.Presence
  alias War.GamePlay.{Server}


  def join("games:" <> game_id, _payload, socket) do
    {:ok, pid} = Server.start
    send self(), {:after_join, pid}
    {:ok, "Joined games:#{game_id}", socket}
  end

  def handle_in("hello", payload, socket) do 
    {:reply, {:ok, payload}, socket}
  end



  def handle_info({:after_join, pid}, socket) do
    state = Server.read pid
    broadcast! socket, "Game:started", state
    {:noreply, socket}
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end




end