defmodule WarWeb.GameChannel do
  use WarWeb, :channel
  alias War.GamePlay.{Server}


  def join("games:" <> game_id, _payload, socket) do
    send(self(), {:after_join, game_id})
    {:ok, socket}
  end


  def handle_info({:after_join, game_id}, socket) do
    {:ok, pid} = Server.start(game_id)

    IO.puts "#### INSPECTING SOCKET ####"
    IO.inspect socket
    IO.puts "#### END SOCKET INSPECTION ####"
  
    {:noreply, socket}
  end


  def handle_in("next_card", payload, socket) do
    
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end




end