require 'test_helper'

class PhotographersTest < ActionDispatch::IntegrationTest
  def setup
  	@photographers = User.all
  end

  test "should get photographers page" do
    get '/photographers/list'
    assert_response :success
    assert assigns(:photographers)
    assert_equal assigns(:photographers), @photographers.paginate(page: 1, per_page: 16)
    assert_template 'photographers/list'

    get '/photographers/list?page=2'
    assert_response :success
    assert assigns(:photographers)
    assert_equal assigns(:photographers), @photographers.paginate(page: 2, per_page: 16)
    assert_template 'photographers/list'
  end
end
