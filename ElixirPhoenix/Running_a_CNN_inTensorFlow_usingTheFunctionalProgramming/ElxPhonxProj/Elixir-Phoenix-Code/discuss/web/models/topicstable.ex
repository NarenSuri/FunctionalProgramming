defmodule Discuss.TopicsTable do 
use Discuss.Web, :model

	schema "topicstable" do 
		field :title, :string
		belongs_to :user, Discuss.User
	end


	def changeset(struct,params \\ %{}) do

		IO.puts "++++++ create topic model  Start*** ++++++++"
		IO.inspect struct
		IO.puts "++++++ create topic model End ####  ++++++++"
		
		IO.puts "++++++ create topic model Start*** ++++++++"
		IO.inspect params
		IO.puts "++++++ create topic model End ####  ++++++++"
		
		
	
		struct
		|> cast(params,[:title])
		|> validate_required([:title])
	end
	
end