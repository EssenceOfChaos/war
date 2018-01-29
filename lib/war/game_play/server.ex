defmodule War.GamePlay.Server do
  use GenServer

  def start_link(id) do
    GenServer.start_link(__MODULE__, id, name: ref(id))
  end

 # Generates global reference
 defp ref(id), do: {:global, {:game, id}}
  
end