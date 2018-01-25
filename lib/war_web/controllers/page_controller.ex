defmodule WarWeb.PageController do
  use WarWeb, :controller

  def index(conn, _params) do
    IO.puts "#### CONN START ####"
    IO.inspect conn, pretty: true
    IO.puts "#### CONN END ####"
    render conn, "index.html"
  end


  def info(conn, _params) do
    render conn, "info.html"
  end
end
