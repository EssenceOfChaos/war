defmodule WarWeb.FallbackController do
  use WarWeb, :controller

    def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
      conn
      |> put_status(:unprocessable_entity)
      |> render(WarWeb.ChangesetView, "error.json", changeset: changeset)
    end

    def call(conn, {:error, :not_found}) do
      conn
      |> put_status(:not_found)
      |> render(WarWeb.ErrorView, :"404")
    end

end