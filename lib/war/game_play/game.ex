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


  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:status, :won, :user_id])

  end
end
