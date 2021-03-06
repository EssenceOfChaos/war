defmodule War.GamePlay.Deck do
  alias __MODULE__
    @moduledoc """
    Provides a Deck context to hold the Card struct.
    """

    defmodule Card do
      defstruct [:value, :suit]
    end

    def new() do
      for value <- values(), suit <- suits() do
        %Card{value: value, suit: suit}
      end
      |> Enum.shuffle
    end

    def deal(cards) do
     hand = Enum.take_random(cards, 26)
     computer = cards -- hand
    |> Enum.map(&to_tuple/1)
    end

    defp to_tuple(
    %Deck.Card{value: value, suit: suit}
    ), do: {value, suit}



    # use values 11-14 for Jacks through Aces
    defp values(), do: Enum.to_list(2..14)
    defp suits(), do: [:spades, :clubs, :hearts, :diamonds]


end
