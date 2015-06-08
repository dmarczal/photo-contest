require 'test_helper'

class ContestsControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get archive" do
    get :archive
    assert_response :success
  end

end
