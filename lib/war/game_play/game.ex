defmodule War.GamePlay.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias War.GamePlay.{Game, Server}

  schema "games" do
    field :status, :string, default: "uninitialized"
    field :won, :boolean, default: false
    belongs_to :user, War.Accounts.User
  ## VIRTUAL FIELDS ##
    field :user_cards, :map, virtual: true
    field :computer_cards, :map, virtual: true

    timestamps()
  end

  @required_fields ~w(status won user_id)a
  @optional_fields ~w()

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end

  def new(id) do
    Server.start_link(id)
  end



end
