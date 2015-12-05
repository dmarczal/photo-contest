require 'test_helper'

class Admin::ListUserTest < ActionDispatch::IntegrationTest

  def setup
    @user = FactoryGirl.create :admin_user
    FactoryGirl.create_list :user, 29
    @users = User.all
  end

  def login
    post_via_redirect "/admin/login", session: {email: @user.email, password: "123123123"}
  end

  test "index page" do
    login
    users = @users.paginate(page: 1, per_page: 10)

    get '/admin/users/index'
    assert_response :success
    assert assigns(:users)

    users.each do |user|

      assert_select "td.name-user", text: user.name
      assert_select "td", text: user.username
      assert_select "td", text: user.email
      assert_select "td", text: user.short_description
    end
    assert_template 'admin/users/index'
  end

  test "should get paging users first page" do
    login
    users = @users.paginate(page: 1, per_page: 10)

    get '/admin/users/index'

    assert_select "ul.pagination" do
      assert_select "li", 5
      assert_select "li.active", "1"
    end
  end

  test "should get paging users second page" do
    login
    users = @users.paginate(page: 1, per_page: 10)

    get '/admin/users/index?page=2'

    assert_select "ul.pagination" do
      assert_select "li", 5
      assert_select "li.active", "2"
    end
  end
end
