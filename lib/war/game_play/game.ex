defmodule War.GamePlay.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias War.GamePlay.Game


  schema "games" do
    field :status, :string
    field :won, :boolean, default: false
    belongs_to :user, War.Accounts.User
  ## VIRTUAL FIELDS ##
    field :user_cards, :map, virtual: true

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
    start_game(game.id)
  end

  def start_game(id) do
    # {:ok, pid} = War.GamePlay.Server.start(id)
    game = %Game
    { user_cards:  War.Deck.new,
      status: "in progress",
      id: id }
  end





end
