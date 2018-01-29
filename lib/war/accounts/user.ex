defmodule War.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias War.Accounts.{User, Encryption}


  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :password_hash, :string
    field :rank, :integer
    field :username, :string
    has_many :games, War.GamePlay.Game
    ## Virtual Fields ##
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

@required_fields ~w(email username password admin)
@optional_fields ~w(rank)

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> downcase_email
    |> encrypt_password
  end

  defp downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end

  defp encrypt_password(changeset) do 
    password = get_change(changeset, :password)
    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :password_hash, encrypted_password)
    else
      changeset
    end
  end

end
