require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  def setup
    @about_page = FactoryGirl.create :about_page
  end

  test "should get page about" do
    get "/#{@about_page.permalink}"
    assert_response :success
    assert assigns(:page)
    assert_template 'static_pages/index'
  end

  test "should return expectation when page not found" do
    get '/nothing'    
    assert_response :not_found    
  end
end
