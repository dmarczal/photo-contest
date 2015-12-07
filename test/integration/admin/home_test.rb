require 'test_helper'

class Admin::HomeTestTest < ActionDispatch::IntegrationTest

  def setup
    @contests = FactoryGirl.create_list :contest, 3
    @user = FactoryGirl.create :admin_user

    @participant = FactoryGirl.create :participant, contest: @contest, status: 0
    @current_contests = FactoryGirl.create_list :current_contests, 3

  end



  def login
    post_via_redirect "/admin/login", session: {email: @user.email, password: "123123123"}
  end


  test "index page" do
    login
    assert_response :success


    assert_select ".panel.panel-info.contest-open" do
      @contests.each do |contest|
        assert_select "a[href=?]", admin_contest_path(contest)
      end
    end

    assert_select ".panel.panel-info.ranking" do
      @current_contests.each do |current_contest|
        assert_select "a[href=?]", admin_contest_path(current_contest)
      end
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
