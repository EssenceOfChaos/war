defmodule War.Factory do
  use ExMachina.Ecto, repo: War.Repo
  alias War.Accounts.User
  
  def user_factory do
    %User{
      email: "coolest@example.com",
      username: "cooldude17",
      rank: 65,
      admin: true,
      password_hash: "ASDLKFJAOIEAO394873948"
    }
  end

end