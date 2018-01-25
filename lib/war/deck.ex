defmodule War.Deck do
    @moduledoc """
    Provides a Deck context to hold the Card struct.
    """

    defmodule Card do
      defstruct [:value, :suit]
    end

    def new do
      for value <- values, suit <- suits do 
        %Card{value: value, suit: suit}
      end |> Enum.shuffle
    end
    # use values 11-14 for Jacks through Aces
    defp values, do: Enum.to_list(2..14)
    defp suits, do: [:spades, :clubs, :hearts, :diamonds]
end