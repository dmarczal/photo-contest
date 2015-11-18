require 'test_helper'
include Warden::Test::Helpers

class UsersNameTest < ActionDispatch::IntegrationTest

  def setup
    @user = FactoryGirl.build(:user)
    @user.name = "Helbert"
    @user.username = "helbert"
    @user.password = "12345678"
    @user.password_confirmation = "12345678"
    @user.save!
  end

  test "login with valid information" do
    get '/users/sign_in'
    post '/users/sign_in', {user: { login: @user.username,
                                    password: "12345678"} }

    follow_redirect!
    assert_template root_path
    assert_response :success
  end

  test "login with invalid information" do
    get '/user/sign_in'
    assert_template '/users/sign_in'
    post '/users/sign_in', {user: { login: @user.username,
                                    password: "12345678910"} }
    assert_not flash.empty?
    get root_path
  end

  test "user name on dropdown" do
    get '/users/sign_in'
    assert_response :success
    post '/users/sign_in', {user: { login: @user.username,
                                    password: "12345678"} }

    follow_redirect!
    assert_template root_path
    assert_select "ul>li>a.dropdown-toggle.user-name", @user.name
  end

  test "is not logged in" do
    get root_path
    assert_template root_path
    assert_select "ul>li.register>a", "Cadastrar-se"
  end


end
