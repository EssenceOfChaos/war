defmodule WarWeb.GameController do
  use WarWeb, :controller
  alias War.Repo
  alias War.GamePlay
  alias War.GamePlay.{Game, Server}


  def index(conn, _params) do
    games = GamePlay.list_games()
    render(conn, "index.html", games: games)
  end

  def new(conn, _params) do
    changeset = 
      conn.assigns[:current_user]
      |> Ecto.build_assoc(:games)
      |> GamePlay.change_game()
      # IO.puts "#### CONN START ####"
      # IO.inspect conn, pretty: true
      # IO.puts "#### CONN END ####"
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"game" => game_params}) do
    changeset =
      conn.assigns[:current_user]
      |> Ecto.build_assoc(:games)
      |> Game.changeset(game_params)
    case Repo.insert(changeset) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: game_path(conn, :show, game))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    game = GamePlay.get_game!(id)
    render(conn, "show.html", game: game)
  end

  def edit(conn, %{"id" => id}) do
    game = GamePlay.get_game!(id)
    changeset = GamePlay.change_game(game)
    render(conn, "edit.html", game: game, changeset: changeset)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = GamePlay.get_game!(id)

    case GamePlay.update_game(game, game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game updated successfully.")
        |> redirect(to: game_path(conn, :show, game))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", game: game, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = GamePlay.get_game!(id)
    {:ok, _game} = GamePlay.delete_game(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: game_path(conn, :index))
  end
end
