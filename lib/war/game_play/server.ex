defmodule War.GamePlay.Server do
  use GenServer
  alias War.GamePlay.Game
  alias War.Deck

  @name __MODULE__

# Client API
  def start() do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

 # Generates global reference
 # defp ref(id), do: {:global, {:game, id}}

 def take_card(pid) do
   GenServer.call(pid, {:take_card})
 end

 def read(pid) do
  GenServer.call(pid, {:read})
 end

 def add(pid, item) do
  GenServer.cast(pid, {:add, item})
 end


# Server Callbacks

  def init(:ok) do
    {:ok, load()}
  end

  def load() do
    deck = Deck.new
    cards = Enum.take_random(deck, 26)
    comp = deck -- cards
   %Game{
     user_cards: cards |> Enum.map(&to_tuple/1),
     status: "in progress",
     computer_cards: comp |> Enum.map(&to_tuple/1),
       }
  end

  defp to_tuple(
    %War.Deck.Card{value: value, suit: suit}
    ), do: {value, suit}


  def handle_call({:take_card}, _from, [card | rest]) do
    {:reply, card, rest}
  end

  def handle_call({:read}, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end



end
