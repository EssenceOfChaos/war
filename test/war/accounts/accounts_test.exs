defmodule War.AccountsTest do
  use War.DataCase

  alias War.Accounts
  import War.Factory
  
  describe "users" do
    
    test "factory builds user struct correctly" do
      attrs = %{username: "Bob the builder", email: "robert-builder@aol.com"}
      user = insert(:user, attrs)
      assert user.username == "Bob the builder"
      assert user.email == "robert-builder@aol.com"
      assert user.id != nil
    end

    
    test "a game belongs to a particular user" do
      user = insert(:user)
      game = insert(:game, user: user)
      assert game.user.username == "John Deere"
    end

    
    test "creating users" do
      {:ok, user} = Accounts.create_user(
        %{username: "bob", 
        email: "bobs-email@aol.com",
        password: "abc123"})
        refute user.id == nil
    end
  end
end