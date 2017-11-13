defmodule Discuss.User do
  use Discuss.Web, :model

  @moduledoc """
  This is the schema created to store the details of the every user who lused the application. Thefollowing details of the user are stored, email, token, provider. we may store more details obtained from authentication call back, but this application is requires only these.
  """   
  
  @doc """
  The schema created for teh users. 
  """  
  
  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    timestamps()
	has_many :topicstable, Discuss.TopicsTable
  end
  
  @doc """
  A changeset to obtain the results trough the elixirs pattern matching. 
  """  

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
  
  
end