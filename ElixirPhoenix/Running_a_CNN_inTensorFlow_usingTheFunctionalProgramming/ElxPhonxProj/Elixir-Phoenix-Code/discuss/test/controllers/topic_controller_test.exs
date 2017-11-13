defmodule Discuss.TopicsControllerTest do
  use Discuss.ConnCase
  alias Discuss.TopicsTable

  
  test "GET-startindex", %{conn: conn} do
    conn = get conn, "/topics/hillroom/mnist/startindex"
    assert html_response(conn, 200) =~ "Must be logged In with your Github accout"	
  end
    
  
end