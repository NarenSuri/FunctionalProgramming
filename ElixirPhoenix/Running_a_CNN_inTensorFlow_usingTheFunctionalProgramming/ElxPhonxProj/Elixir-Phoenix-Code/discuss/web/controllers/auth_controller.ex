defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth
  alias Discuss.User
  
  @moduledoc """
  This module is to give the autorization to the application. The user should have a github account to scussefully use the application.
  """  
  
  
  @doc """
  The callback(conn, params) function is used to define the call back from github back to the application. 
  """      
  def callback(conn, params) do
		IO.puts  "++++++++++++++++++++++++++++++ auth +++++++++++++++++++++++"
		IO.inspect(conn.assigns)
		IO.puts  "++++++++++++++++++++++++++++++ auth +++++++++++++++++++++++"
		IO.inspect(params)
		IO.puts  "++++++++++++++++++++++++++++++ auth +++++++++++++++++++++++"

	%{assigns: %{ueberauth_auth: auth}} = conn
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)
    signin(conn, changeset)
  end


  @doc """
  The insert_or_update_user(changeset) function is used to create the new user once they login through the authentication provider - github. If the user has already login in the past it uses the changeset to update the record if necessary.
  """ 
  
  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
  
  @doc """
  The signin(conn, changeset) function is used to signin the user based on the information in the changeset computed. If the error occurs in signing in, this flashes an error. On a sucessful login, the user will be redirected to the application to start using the application. This funciton also creates a session and maintinas the user details for a auto singon when the user arrives later, unless they have cleaned cookies or session got terminated or loged-out from the authentication privoder manually. 
  """  
  
    defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :useapp))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: topic_path(conn, :startindex))
    end
  end
  
  @doc """
  The signout(conn, _params) function is used to signout the user and clean the session.
  """  
  
    def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: topic_path(conn, :startindex))
  end
  
end