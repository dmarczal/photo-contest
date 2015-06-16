require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  def setup
  	@page = pages(:about)
  end

  test "should get page about" do
    get '/about'
    assert_response :success
    assert assigns(:page)
    assert_template 'static_pages/index'
  end

  test "should return excpection when page not found" do
    get '/nothing'    
    assert_response :not_found
    #assert_raise ActionController::RoutingError
  end

end
