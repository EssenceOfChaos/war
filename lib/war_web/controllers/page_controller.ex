defmodule WarWeb.PageController do
  use WarWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end


  def info(conn, _params) do
    render conn, "info.html"
  end
end
