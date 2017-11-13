defmodule Discuss.TopicController do
  use Discuss.Web, :controller
  alias Discuss.TopicsTable

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete, :startcnnmnist]
  
  
  def new(conn, params) do
  
					IO.puts "++++++ new conn topic controller Start*** ++++++++"
					IO.inspect conn
					IO.puts "++++++ new conn topic controller End ####  ++++++++"
					
					struct = %Discuss.TopicsTable{}
					
					IO.puts "++++++ new params topic controller Start*** ++++++++"
					IO.inspect params
					IO.puts "++++++ new params topic controller End ####  ++++++++"
  
	struct = %Discuss.TopicsTable{}	
	
					IO.puts "++++++ new struct from topic-controller Start*** ++++++++"
					IO.inspect struct
					IO.puts "++++++ new struct from topic-controller End ####  ++++++++"
					
	changeset = TopicsTable.changeset(struct,params)
					IO.puts "++++++ new changeset from topic-controller Start*** ++++++++"
					IO.inspect changeset
					IO.puts "++++++ new changeset from topic-controller End ####  ++++++++"
					
	render conn, "new.html", changeset: changeset
  end
    
  
  
  
  def create(conn, params) do
	IO.puts "++++++ create topic controller Start*** ++++++++"
	IO.inspect params
	IO.puts "++++++ create topic controller End ####  ++++++++"
	
	struct = %Discuss.TopicsTable{}
	
	IO.puts "++++++ create struct topic controller Start*** ++++++++"
	IO.inspect struct
	IO.puts "++++++ create struct topic controller End ####  ++++++++"
	
	
	%{"topics_table" => paramObtained} = params

	IO.puts "++++++ create paramObtained topic controller Start*** ++++++++"
	IO.inspect paramObtained
	IO.puts "++++++ create paramObtained topic controller End ####  ++++++++"
	
	changeset1 = TopicsTable.changeset(struct,paramObtained)
	IO.puts "++++++ create changeset1 topic controller Start*** ++++++++"
	IO.inspect changeset1
	IO.puts "++++++ create changeset1 topic controller End ####  ++++++++"
	

	
   changeset= conn.assigns.user |> build_assoc(:topicstable) |> TopicsTable.changeset(paramObtained)
	
	IO.puts "++++++ create changeset topic controller Start*** ++++++++"
	IO.inspect changeset
	IO.puts "++++++ create changeset topic controller End ####  ++++++++"
		
	
	
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
	    IO.puts "++++++ create problem Error Print From topic controller Start*** ++++++++"
		IO.inspect changeset
		IO.puts "++++++ create problem Error Print From topic controller End ####  ++++++++"
        render conn, "new.html", changeset: changeset
    end
	
	
	
  end  
  
   
  def index(conn, params) do
	IO.puts "++++++ create topic controller Start*** ++++++++"
	IO.inspect params
	IO.puts "++++++ create topic controller End ####  ++++++++"
	
    allResultsFromDB = Discuss.Repo.all(Discuss.TopicsTable)
	
	IO.puts "++++++ index topic controller Start*** ++++++++"
	IO.inspect allResultsFromDB
	IO.puts "++++++ index topic controller End ####  ++++++++"
	
	render conn, "index.html", allResultsFromDB: allResultsFromDB
  end 
  
  
  def edit(conn, params) do
  
	IO.puts "++++++ edit topic controller Start*** ++++++++"
	IO.inspect params
	IO.puts "++++++ edit topic controller End ####  ++++++++"
	
	%{"id" => topicid} = params
	fetchRecord = Repo.get(TopicsTable,topicid)
	
	IO.puts "++++++ edit fetchRecord topic controller Start*** ++++++++"
	IO.inspect fetchRecord
	IO.puts "++++++ edit fetchRecord topic controller End ####  ++++++++"
	
	struct = %Discuss.TopicsTable{}

	IO.puts "++++++ edit struct topic controller Start*** ++++++++"
	IO.inspect struct
	IO.puts "++++++ edit struct topic controller End ####  ++++++++"
	
	changesetForEdit = TopicsTable.changeset(fetchRecord)
	
	IO.puts "++++++ edit changesetForEdit topic controller Start*** ++++++++"
	IO.inspect changesetForEdit
	IO.puts "++++++ edit changesetForEdit topic controller End ####  ++++++++"
	
    render conn, "edit.html", changesetForEdit: changesetForEdit, fetchRecord: fetchRecord
	 
  end
  
  
  def update(conn, params) do
  
	IO.puts "++++++ update params topic controller Start*** ++++++++"
	IO.inspect params
	IO.puts "++++++ update params topic controller End ####  ++++++++"
	
	%{"id" => topicId,"topics_table" => topicTitle} = params
	originalValueInDB = Repo.get(TopicsTable, topicId)
	
	IO.puts "++++++ update originalValueInDB topic controller Start*** ++++++++"
	IO.inspect originalValueInDB
	IO.puts "++++++ update originalValueInDB topic controller End ####  ++++++++"
	
	changeset = Discuss.TopicsTable.changeset(originalValueInDB,topicTitle)
	
	case Repo.update(changeset) do
		{:ok, _topic} ->
			conn
			|> put_flash(:info, "Topic Updated")
			|> redirect(to: topic_path(conn, :index))
		  
		{:error, changeset} ->
			render conn, "edit.html", changeset: changeset, topic: originalValueInDB
    end

	
  end
  
  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(TopicsTable, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end
  
  
end