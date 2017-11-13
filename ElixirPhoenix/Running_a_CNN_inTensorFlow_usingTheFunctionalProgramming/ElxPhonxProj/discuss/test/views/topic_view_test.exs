defmodule Discuss.TopicViewTest do
  use Discuss.ConnCase, async: true 
  import Discuss.TopicsTable
  import Discuss.TopicController    
  
  
  @moduledoc """
  This module is to test the funcitonality of the application.
  """  
  
  
  @doc """
  This test checks if we are able to reach the use application page sucessfully.
  """    
  
  
  test "useappFunctionality" do  
	  conn = get conn, "/topics/hillroom/mnist/startindex/useapp"
	  IO.inspect conn
	  params = %{}
	  resultChangeset = Discuss.TopicsTable.changeset(%Discuss.TopicsTable{},params)
	  refute resultChangeset.valid?  
  end
  
end
  