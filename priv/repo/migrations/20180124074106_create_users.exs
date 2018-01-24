defmodule War.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :admin, :boolean, default: false, null: false
      add :password_hash, :string
      add :rank, :integer

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
