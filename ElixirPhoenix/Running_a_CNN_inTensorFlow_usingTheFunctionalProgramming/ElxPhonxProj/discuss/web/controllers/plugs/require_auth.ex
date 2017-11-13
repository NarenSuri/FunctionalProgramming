defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Router.Helpers

  @defmodule """
  This customized plugin makes sures that certain sentsitive pages are never accesed with out signing in. 
  """   
  
  @doc """
  This plugin is run before running the sesntive pages of the application. This makes only those users who signed in with their github to access the applciaion.  
  """ 
  
  
  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.topic_path(conn, :startindex))
      |> halt()
    end
  end
end