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

 def battle(pid) do
   GenServer.call(pid, {:battle})
 end

 def take_card(pid) do
   GenServer.call(pid, {:take_card})
 end

 def read(pid) do
  GenServer.call(pid, {:read})
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






# def turn(%{user_cards: [], comp_cards: []}), do: draw
# def turn(%{user_cards: []}), do: comp_wins
# def turn(%{comp_cards: []}), do: user_wins
# def turn(g = %{user_cards: [user_first|user_rest], comp_cards: [comp_first|comp_rest]}) do
#     case Deck.highest_value(user_first, comp_first) do
#         user_first ->
#             new_state = %{g | user_cards: user_rest ++ [user_first, comp_first] ++ g.pile, 
#                               comp_cards: comp_rest, pile =[]}
#             turn(new_state)
#        comp_first ->
             
#        equal ->
           
#             {user_to_pile, user_left} = Enum.split(user_rest, 3)
#             {comp_to_pile, comp_left} = Enum.split(comp_rest, 3)
#             pile = [ user_first, comp_first | g.pile ] ++ user_to_pile ++ comp_to_pile,
#             new_state = %{g | user_cards: user_left, comp_cards: comp_left, pile = pile}
#             turn(new_state)
#     end
# end




  defp to_tuple(
    %War.Deck.Card{value: value, suit: suit}
    ), do: {value, suit}


  def handle_call({:take_card}, _from, [card | rest]) do
    {:reply, card, rest}
  end

  def handle_call({:read}, _from, state) do
    {:reply, state, state}
  end


  def handle_call({:battle}, _from, %Game{user_cards: user_hand, computer_cards: computer_hand} = state) do
    
    [first | rest] = user_hand
    user_card = elem(first, 0)

    [first | rest] = computer_hand
    computer_card = elem(first, 0)

    {:reply, compare(computer_card, user_card), state}
  end



  defp compare(computer_card, user_card, state) when computer_card > user_card do
    computer_cards ++ [computer_card, user_card]
  end

  defp compare(computer_card, user_card, state) when computer_card < user_card do
    user_cards ++ [computer_card, user_card]
  end









  defp compare([computer_card | computer_hand], [user_card | user_hand]) when computer_card < user_card do
    user_hand ++ [computer_card, user_card]
  end

  defp compare([computer_card | computer_hand], [user_card | user_hand]) when computer_card == user_card do
    #WAR!
  end




  ########################## rewrite below
  # def handle_call({:take_card}, _from, {computer_cards, player_cards}) do
  #   compare(computer_cards, player_cards, [])
  #   # ...
  # end
  
  # defp compare([], [], acc), do: :lists.reverse(acc)

  # defp compare([computer_card | computer_cards], [player_card | player_cards], acc) when computer_card > player_card do
  #   compare(computer_cards, player_cards, [:computer_wins | acc])
  # end

  # defp compare([computer_card | computer_cards], [player_card | player_cards], acc) when computer_card < player_card do
  #   compare(computer_cards, player_cards, [:player_wins | acc])
  # end

  ############################ rewrite above





  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end



end




