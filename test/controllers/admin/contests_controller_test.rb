require 'test_helper'

class Admin::ContestsControllerTest < ActionController::TestCase
  setup do
    @admin_contest = admin_contests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_contests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_contest" do
    assert_difference('Admin::Contest.count') do
      uploaded = fixture_file_upload('rails.png', 'image/png')
      post :create, admin_contest: { closing: @admin_contest.closing, closing_enrollment: @admin_contest.closing_enrollment, folder: uploaded ,description: @admin_contest.description, opening: @admin_contest.opening, opening_enrollment: @admin_contest.opening_enrollment, title: @admin_contest.title }
    end

    assert_redirected_to admin_contest_path(assigns(:admin_contest))
  end

  test "should show admin_contest" do
    get :show, id: @admin_contest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_contest
    assert_response :success
  end

  test "should update admin_contest" do
    patch :update, id: @admin_contest, admin_contest: { closing: @admin_contest.closing, closing_enrollment: @admin_contest.closing_enrollment, description: @admin_contest.description, opening: @admin_contest.opening, opening_enrollment: @admin_contest.opening_enrollment, title: @admin_contest.title }
    assert_redirected_to admin_contest_path(assigns(:admin_contest))
  end

  test "should destroy admin_contest" do
    assert_difference('Admin::Contest.count', -1) do
      delete :destroy, id: @admin_contest
    end

    assert_redirected_to admin_contests_path
  end
end
