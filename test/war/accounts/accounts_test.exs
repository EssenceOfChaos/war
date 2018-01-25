defmodule War.AccountsTest do
  use War.DataCase

  alias War.Accounts
  import War.Factory

  describe "users" do
    alias War.Accounts.User

    @valid_attrs %{admin: true, email: "cooldude19@aol.com", password_hash: "abc123", rank: 42, username: "cooldude19"}
    @update_attrs %{admin: false, email: "different_email@aol.com", password_hash: "secretpass", rank: 43, username: "coolerdude19"}
    @invalid_attrs %{admin: nil, email: nil, password_hash: nil, rank: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.admin == true
      assert user.email == "cooldude19@aol.com"
      # assert user.rank == 42
      assert user.username == "cooldude19"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.admin == false
      assert user.email == "different_email@aol.com"
      # assert user.rank == 43
      assert user.username == "coolerdude19"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
