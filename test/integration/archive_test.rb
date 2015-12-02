require 'test_helper'

class ArchiveTest < ActionDispatch::IntegrationTest

	test "should get archives page" do 
		get '/contests/archive'
	    assert_response :success
	    
	end
end
