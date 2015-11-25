require 'test_helper'

class PhotographersControllerTest < ActionController::TestCase
	setup do
		@photographer = FactoryGirl.create :user
	end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get show" do
    get :show, id: @photographer.id
    assert_response :success
  end

end
