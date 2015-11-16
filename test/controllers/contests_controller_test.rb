require 'test_helper'

class ContestsControllerTest < ActionController::TestCase
  def setup
    @contest = FactoryGirl.create :contest
  end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get show" do
    get :show, id: @contest.id
    assert_response :success
  end

  test "should get archive" do
    get :archive
    assert_response :success
  end

end
