require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in FactoryGirl.create(:admin_user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

end
