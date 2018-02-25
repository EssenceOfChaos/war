defmodule WarWeb.GameView do
  use WarWeb, :view
  alias WarWeb.Helpers.FormatHelper
  alias War.GamePlay.Server

  def render_card(card) do
    FormatHelper.format_card(card)
  end

  def cards_left(cards) do
    length(cards)
  end

  def next_card(cards) do
    game = Server.read(War.GamePlay.Server)
    user_hand = game.user_cards
    [next | rest] = user_hand
    next
  end

  def user_hand(pid) do
    %War.GamePlay.Game{user_cards: user_hand} = Server.read(pid)
    user_hand
    # in template user_cards and computer_cards are both showing nil!?
  end

end
