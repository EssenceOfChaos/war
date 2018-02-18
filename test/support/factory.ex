defmodule War.Factory do
  use ExMachina.Ecto, repo: War.Repo
  alias War.Accounts.User
  alias War.GamePlay.Game
  
  def user_factory do
    %User{
      username: "John Deere",
      email: "john-deere@aol.com",
      password: "abc123",
      admin: false,
      rank: 42
    }
  end

  def game_factory do
    %Game{
      status: "unintialized",
      won: false,
      user: build(:user)
    }

  end

end