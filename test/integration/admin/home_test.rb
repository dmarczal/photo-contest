require 'test_helper'

class Admin::HomeTestTest < ActionDispatch::IntegrationTest

  def setup

    @user = FactoryGirl.create :admin_user

    @participant = FactoryGirl.create :participant, contest: @contest, status: 0

    @current_contest = FactoryGirl.build :current_contest
    @current_contest.save validate: false

    @contest = FactoryGirl.build :contest
    @contest.save validate: false


  end



  def login
    post_via_redirect "/admin/login", session: {email: @user.email, password: "123123123"}
  end


  test "index page" do
    login
    assert_response :success

    assert_select ".panel.panel-info.contest-open" do
      assert_select "a[href=?]", admin_contest_path(@contest)
    end

    assert_select ".panel.panel-info.ranking" do
      assert_select "a[href=?]", admin_contest_path(@current_contest)
    end

  end

  test "links page" do
      login
      get admin_root_path
      assert_select "a[href=?]", admin_root_url, count: 2
      assert_select "a[href=?]", admin_contests_url
      assert_select "a[href=?]", admin_pages_url
      assert_select "a[href=?]", admin_logout_path
  end

end
