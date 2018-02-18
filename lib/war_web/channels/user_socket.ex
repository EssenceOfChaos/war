defmodule WarWeb.UserSocket do
  use Phoenix.Socket
  alias War.Repo

  ## Channels
  channel "room:lobby", WarWeb.RoomChannel
  channel "games:*", WarWeb.GameChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket,
    timeout: 45_000
  # transport :longpoll, Phoenix.Transports.LongPoll

  @max_age 2 * 7 * 24 * 60 * 60


  def connect(%{"token" => token}, socket) do
      case Phoenix.Token.verify(socket, "user auth", token, max_age: @max_age) do
        {:ok, user_id} ->
          user = Repo.get!(War.Accounts.User, user_id)
          {:ok, assign(socket, :current_user, user)}
          {:error, _reason} ->
           :error
      end
  end

  # def connect(_params, socket) do
  #   {:ok, socket}
  # end

  # Socket id's are topics that allow you to identify all sockets for a given user:

  def id(socket), do: "user_socket:#{socket.assigns.current_user.id}"
    # def id(socket), do: "user_socket:#{socket.assigns.user_id}"
    # def id(socket), do: "user_socket:#{socket.assigns.current_user}"

  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     WarWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
