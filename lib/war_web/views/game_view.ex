defmodule WarWeb.GameView do
  use WarWeb, :view
  alias War.GamePlay.Game
# playing_cards/2_of_clubs.png

  def render_card_image() do
    cond do
      {2, :hearts} ->  "/images/playing_cards/2_of_hearts.png"
      {3, :hearts} -> "/images/playing_cards/3_of_hearts.png"
      {4, :hearts} -> "/images/playing_cards/4_of_hearts.png"
    end
    
  end

  def next_card(cards) do
    hd(cards)
  end

 
  

end
