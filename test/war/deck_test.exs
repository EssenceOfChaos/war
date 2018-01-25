defmodule War.DeckTest do
  use ExUnit.Case

  test "create a 52 card deck" do
    deck = War.Deck.new()
    assert length(deck) == 52
  end
end