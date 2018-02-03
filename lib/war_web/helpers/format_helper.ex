defmodule WarWeb.Helpers.FormatHelper do
    @moduledoc """
      Provides format-related functions.
    """

  def format_card({value, suit}) do
     "/images/playing_cards/#{value}_of_#{suit}.png"
  end
  

end
