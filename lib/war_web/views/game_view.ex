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


end
