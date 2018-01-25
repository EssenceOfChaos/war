defmodule WarWeb.Router do
  use WarWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug WarWeb.Plugs.SetUser, repo: War.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WarWeb do
    pipe_through :browser
    get "/", PageController, :index
    get "/info", PageController, :info
    resources "/users", UserController
           ## Routes for sessions ##
  get    "/login",  SessionController, :new
  post   "/login",  SessionController, :create
  delete "/logout", SessionController, :delete

  end

  # Other scopes may use custom stacks.
  # scope "/api", WarWeb do
  #   pipe_through :api
  # end
end
