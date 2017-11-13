defmodule Discuss.TopicController do
  use Discuss.Web, :controller
  alias Discuss.TopicsTable

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete, :useapp, :classifyimage]
  
  
  @moduledoc """
  The Topic Controller is the heart of this  application. Most of he logic requests are routed here and processed.
  """   
  
  @doc """
  The welcome page is a simple dummy page with no logic. this is a test page. 
  """    
  def welcome(conn, params) do
  render conn, "welcome.html"
  end
  
  @doc """
  The start index functionality lets the users to be redirected to the start index page unless they signin using the github. This page works as a shield to the applcation, where users have to first signin and then they are automatically redicted to the applicaiton page only after a sucessful signon. The users are required to authenticate themselves using their github account. 
  """   
  def startindex(conn, params) do 
    user_id = get_session(conn, :user_id)

	
			IO.puts "++++++ startindex conn topic controller Start*** ++++++++"
			IO.inspect conn
			IO.puts "++++++ startindex conn topic controller End ####  ++++++++"
			IO.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
										
			IO.puts "++++++ startindex params topic controller Start*** ++++++++"
		    IO.inspect params
			IO.puts "++++++ startindex params topic controller End ####  ++++++++"
			IO.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
					
	
    cond do
      user_id -> 		  
		conn
		|> put_flash(:info, "Welcome Back... You are automatically rediected to app as you signedin already...")
        |> redirect(to: topic_path(conn, :useapp))
		
      true ->
        render conn, "startindexpage.html"
    end
  
  end
  
  @doc """
  Once the user sucessfully login, they are redirected ot his page. The user is provided with the page where they can upload an image for accesing the CNN powered digit classification. 
  """  
  
  def useapp(conn, params) do  

					IO.puts "++++++ useapp conn topic controller Start*** ++++++++"
					IO.inspect conn
					IO.puts "++++++ useapp conn topic controller End ####  ++++++++"
					IO.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
										
					IO.puts "++++++ useapp params topic controller Start*** ++++++++"
					IO.inspect params
					IO.puts "++++++ useapp params topic controller End ####  ++++++++"
					IO.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  
	struct = %Discuss.TopicsTable{}	
	
					IO.puts "++++++ useapp struct from topic-controller Start*** ++++++++"
					IO.inspect struct
					IO.puts "++++++ useapp struct from topic-controller End ####  ++++++++"
					IO.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
					
	changeset = TopicsTable.changeset(struct,params)
					IO.puts "++++++ useapp changeset from topic-controller Start*** ++++++++"
					IO.inspect changeset
					IO.puts "++++++ useapp changeset from topic-controller End ####  ++++++++"
					IO.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	
	
  render conn, "useapppage.html", changeset: changeset
  end
  
  @doc """
  The classifyimage(conn, params) function is used to classify the image. Also, on a sucessful upload of the file, the file is copied to the temp and the file name is modified to avoid the conflict in the file names gnereated by the various users. The file name is relaed with their gihub profile id and the timestamp of sec after the georgian time, this way there will no name collisions. The obtained file is then passed to the CNN which is trained already. The file user has sent is first validated to check if its an image. If the file is an image then the tensorflow code will use the trained weights and clasify the digit. 
  """   
  def classifyimage(conn, params) do  
  
  					IO.puts "++++++ classifyimage conn topic controller Start*** ++++++++"
					IO.inspect conn
					IO.puts "++++++ classifyimage conn topic controller End ####  ++++++++"
					IO.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
										
					IO.puts "++++++ classifyimage params topic controller Start*** ++++++++"
					IO.inspect params
					IO.puts "++++++ classifyimage params topic controller End ####  ++++++++"
					IO.puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
					
		%{"topics_table" => paramsObtained} = params
		%{"photo"=> paramvalues} = paramsObtained

		IO.puts "************** classifyimage params *************** ++++++++"
		IO.inspect paramvalues.path
		IO.inspect paramvalues.filename
		
		user_id = get_session(conn, :user_id)
		
		if paramvalues.path != "" and paramvalues.filename != "" and user_id != "" do
			extension = Path.extname(paramvalues.filename)
			file = paramvalues.path<>"/"<> paramvalues.filename
			IO.inspect file
			IO.inspect extension
			ress = :calendar.universal_time()
			tofilename = Enum.join(Enum.concat(Tuple.to_list(elem(ress,0)),Tuple.to_list(elem(ress,1))),"")
			finalfilename = "/home/ubuntu/ElxPhonxProj/TensoFlowTestImages/user-#{user_id}-#{tofilename}#{extension}"
			cond do 
				extension == ".jpg" or extension == ".png" or extension == ".JPG" or extension == ".PNG" or extension == ".jpeg" or extension == ".JPEG" ->
					File.cp_r(paramvalues.path,finalfilename)
				true ->				
					conn
					|> put_flash(:error, "Please make sure the file extension is one of the following, .jpg or  .png or .JPG or .PNG or .jpeg or .JPEG")
					|> redirect(to: topic_path(conn, :useapp))
			end
			
		resultPrediction = System.cmd "python", ["/home/ubuntu/ElxPhonxProj/TensorFlow-MNIST-master/TensorFlow-MNIST-master/test.py", finalfilename]

		splitRes = String.split( elem(resultPrediction,0), "splithere")
		IO.inspect splitRes
		predictedAs =  Enum.at(splitRes,1)|> String.trim()

		IO.inspect predictedAs
		predictionProb =  Enum.at(splitRes,2)|> String.trim()|> String.replace("\n", "")
		IO.inspect predictionProb		
	    changeset = TopicsTable.changeset(%Discuss.TopicsTable{},%{})
		
	    render conn, "resultpage.html",changeset: changeset,predictedAs: predictedAs, predictionProb: predictionProb
			
		end
	conn
	|> put_flash(:error, "something went wrong, please try again!!")
	|> redirect(to: topic_path(conn, :startindex))
  end
  
 
  
  
end