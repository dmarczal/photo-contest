require 'test_helper'

class Admin::HomeControllerTest < ActionController::TestCase
  test "should get index" do
		get :index
		assert_redirected_to admin_login_path
  end
end
