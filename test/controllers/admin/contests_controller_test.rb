require 'test_helper'

class Admin::ContestsControllerTest < ActionController::TestCase
  
  setup do
    @contest = contests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contest" do
    assert_difference('Contest.count') do
      uploaded = fixture_file_upload('rails.png', 'image/png')
      post :create, contest: { closing: @contest.closing, closing_enrollment: @contest.closing_enrollment, folder: uploaded ,description: @contest.description, opening: @contest.opening, opening_enrollment: @contest.opening_enrollment, title: @contest.title }
    end

    assert_redirected_to admin_contest_path(assigns(:contest))
  end

  test "should show admin_contest" do
    get :show, id: @contest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contest
    assert_response :success
  end

  test "should update contest" do
    patch :update, id: @contest, contest: { closing: @contest.closing, closing_enrollment: @contest.closing_enrollment, description: @contest.description, opening: @contest.opening, opening_enrollment: @contest.opening_enrollment, title: @contest.title }
    assert_redirected_to admin_contest_path(assigns(:contest))
  end

  test "should destroy contest" do
    assert_difference('Contest.count', -1) do
      delete :destroy, id: @contest
    end

    assert_redirected_to admin_contests_path
  end
end
