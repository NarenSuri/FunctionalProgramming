defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
	plug Discuss.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  @moduledoc """
  This Router module helps in redirecting the application based on the user request. It controls in routing the requests of user t the relevant functions.
  """  
  
  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack
    
	get "/", PageController, :index

	
	get "/topics/welcome" , TopicController, :welcome
	get "/topics/hillroom/mnist/startindex", TopicController, :startindex
	get "/topics/hillroom/mnist/startindex/useapp", TopicController, :useapp
	post "/topics/hillroom/mnist/startindex/classify", TopicController,:classifyimage
	post "/topics/hillroom/mnist/startindex", TopicController, :startindex
  end
  
  
    scope "/auth", Discuss do
    pipe_through :browser
    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
	
  end
  

  # Other scopes may use custom stacks.
   scope "/api", Discuss do
     pipe_through :api	
	 resources "/topics/hillroom/mnist/startindex", TopicController		
   end
end
