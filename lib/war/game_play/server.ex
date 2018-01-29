defmodule War.GamePlay.Server do
  use GenServer
  alias War.GamePlay.Game

  def start(id) do
    GenServer.start_link(__MODULE__, id, name: ref(id))
  end

 # Generates global reference
 defp ref(id), do: {:global, {:game, id}}


 def init do
  game = %Game
  { user_cards:  War.Deck.new |> Enum.take_random(26),
    status: "in progress" }

 end
  
end