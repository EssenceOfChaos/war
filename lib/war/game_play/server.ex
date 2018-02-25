defmodule War.GamePlay.Server do
  use GenServer
  alias War.GamePlay.{Game, Deck}


# Client API
  def start_link(id) do
    GenServer.start_link(__MODULE__, :ok, name: {:global, "game:#{id}"})
  end

 def battle(pid) do
   GenServer.call(pid, :battle)
 end

 def read(pid) do
  GenServer.call(pid, :read)
 end


# Server Callbacks

  def init(:ok) do
    {:ok, load()}
  end

  def load() do
    deck = Deck.new()
    cards = Enum.take_random(deck, 26)
    comp = deck -- cards
   %Game{
     user_cards: cards |> Enum.map(&to_tuple/1),
     status: "in progress",
     computer_cards: comp |> Enum.map(&to_tuple/1),
       }
  end

  defp to_tuple(
    %Deck.Card{value: value, suit: suit}
    ), do: {value, suit}


  def handle_call(:read, _from, state) do
    {:reply, state, state}
  end

  def handle_call(
    :battle,
    _from,
    %Game{
      user_cards: []
    } = state
  ) do
    new_state = Map.merge(state, %{status: "finished", won: false})
    {:reply, "User loses", new_state}
  end

  def handle_call(
    :battle,
    _from,
    %Game{
      computer_cards: []
    } = state
  ) do
   new_state = Map.merge(state, %{status: "finished", won: true})
    {:reply, "User wins", new_state}
  end

  def handle_call(
    :battle,
    _from,
    %Game{
      user_cards: [{user_card, user_card_suit} | user_cards_rest],
      computer_cards: [{computer_card, computer_card_suit} | computer_cards_rest]
    } = state
  ) do
    
    cond do
      user_card > computer_card ->
        new_state = Map.merge(state, %{
          user_cards: user_cards_rest ++ [{user_card, user_card_suit}, {computer_card, computer_card_suit}],
          computer_cards: computer_cards_rest
          })
      {:reply, "User wins with #{user_card}!", new_state}

      computer_card > user_card ->
        new_state = Map.merge(state, %{
          computer_cards: computer_cards_rest ++ [{user_card, user_card_suit}, {computer_card, computer_card_suit}],
          user_cards: user_cards_rest
        })
      {:reply, "Computer wins with #{computer_card}!", new_state}

      user_card == computer_card ->
        # war occurs
 
      new_state = Map.merge(state, %{
        computer_cards: computer_cards_rest,
        user_cards: user_cards_rest
      })
        {:reply, "War occurs with #{user_card} vs. #{computer_card}!", new_state}
    end
  end


end
