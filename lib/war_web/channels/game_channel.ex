defmodule WarWeb.GameChannel do
  use WarWeb, :channel
  alias War.GamePlay.{Server}
  require Logger


  def join("games:" <> game_id, _payload, socket) do
    Logger.debug "Joining Game channel #{game_id}", game_id: game_id
    case War.GamePlay.Game.new(game_id) do
      {:ok, pid} ->
        # handle success
        {:ok, assign(socket, :game_id, game_id)}
      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end


  def handle_info({:after_join, game_id}, socket) do
    {:noreply, socket}
  end


  def handle_in("next_card", _payload, socket) do
    IO.puts "#### INSPECTING SOCKET ####"
    IO.inspect socket
    IO.puts "#### END SOCKET INSPECTION ####" 
    {:reply, :ok, socket}
  end


end