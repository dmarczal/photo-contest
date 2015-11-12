require 'test_helper'

class Admin::HomeControllerTest < ActionController::TestCase
  test "should get index" do
   get :index
   assert_redirect_to new_user_session
  end
end
