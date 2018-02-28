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
      user = conn.assigns[:current_user]
      case Game.new(user.id) do
        {:ok, pid} ->
          %Game{user_cards: user_hand, computer_cards: comp_hand, status: status} =
          Server.read(pid)
          conn
          |> put_session(:game, pid)
          |> render("new.html", user_hand: user_hand, comp_hand: comp_hand, status: status)
        {:error, {:already_started, pid}} ->
          %Game{user_cards: user_hand, computer_cards: comp_hand, status: status} =
          Server.read(pid)
          conn
          |> render("new.html", user_hand: user_hand, comp_hand: comp_hand, status: status)
      end
        
  end

  def battle(conn, _params) do
    case Server.battle(War.GamePlay.Server) do
    "Computer wins" ->
        %Game{user_cards: user_hand, computer_cards: comp_hand, status: status} =
        Server.read(War.GamePlay.Server)
        conn
        |> put_flash(:error, "Computer wins round")
        |> render("new.html", user_hand: user_hand, comp_hand: comp_hand, status: status)
      "User wins" ->
          %Game{user_cards: user_hand, computer_cards: comp_hand, status: status} =
        Server.read(War.GamePlay.Server)
        conn
        |> put_flash(:info, "User wins round")
        |> render("new.html", user_hand: user_hand, comp_hand: comp_hand, status: status)
      "War occurs" ->
        %Game{user_cards: user_hand, computer_cards: comp_hand, status: status} =
        Server.read(War.GamePlay.Server)
        conn
        |> put_flash(:info, "War occcurs!")
        |> render("new.html", user_hand: user_hand, comp_hand: comp_hand, status: status)
    end
  end

  def create(conn, _) do
    changeset =
      conn.assigns[:current_user]
      |> Ecto.build_assoc(:games)
    case Repo.insert(changeset) do
      {:ok, game} ->
        {:ok, pid} = Game.new(game.id)
        %Game{user_cards: user_hand, computer_cards: comp_hand, status: status} =
        Server.read(pid)
        conn
        |> put_session(:game, game)
        |> render("show.html", user_hand: user_hand, comp_hand: comp_hand, status: status)
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
