require 'test_helper'

class UsersNameTest < ActionDispatch::IntegrationTest

  def setup

  end

  test "login with valid information" do
    @user = User.create!(name: "Helbert", email: "helbert@gmail.com",
                        username: "helbert", password: "12345678")


    post '/users/sign_in', user: { login: @user.username, password: 'password' }

    p body
    assert_redirected_to root_url
    follow_redirect!

    # assert_template 'home/index'
    # assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", destroy_user_session_path
    # assert_select "a[href=?]", user_path(@user)
  end

  test "user name" do
    @user = User.create(name: "Helbert", email: "helbert@gmail.com",
                        login: "helbert", password: "12345678")

    get participants_path(@user)
    assert_template 'home/index'
    assert_select "ol" do
      assert_select 'ol>li>a[href=?]', text:@user.name
    end

  end

end
