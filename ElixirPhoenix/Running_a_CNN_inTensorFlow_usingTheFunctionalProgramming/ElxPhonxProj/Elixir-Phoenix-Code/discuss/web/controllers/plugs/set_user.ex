defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User
  @defmodule """
  This is a custom module plug designed to set the user details to the connection. 
  """ 
  
  @doc """
  This customized plugin heps us to seet the user detaisl to the connections. Also, it helps to create a session with the user details. 
  """  
  
  def init(_params) do
  end

  def call(conn, _params) do 
  
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end

  end
  
end