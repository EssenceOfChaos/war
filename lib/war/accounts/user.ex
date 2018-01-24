defmodule War.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias War.Accounts.User


  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :password_hash, :string
    field :rank, :integer
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :admin, :password_hash, :rank])
    |> validate_required([:username, :email, :admin, :password_hash, :rank])
    |> unique_constraint(:email)
  end
end
