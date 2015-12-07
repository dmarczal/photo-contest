require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryGirl.build(:user)
    @user.name = "Teste usuário"
    @user.username = "test"
    @user.password = "12345678"
    @user.password_confirmation = "12345678"
    @user.save!
  end

  test "sign_up user page" do
    get '/users/sign_up'
    assert_response :success
    assert assigns(:user)

    assert_select "input[id=?]", "user_username"
    assert_select "input[id=?]", "user_name"
    assert_select "textarea[id=?]", "user_short_description"
    assert_select "textarea[id=?]", "user_biography"
    assert_select "input[id=?]", "user_email"
    assert_select "input[id=?]", "user_password"
    assert_select "input[id=?]", "user_password_confirmation"
    assert_select "input[value=?]", "Finalizar"

  end

  test "edit user page" do
    post '/users/sign_in', {user: { login: @user.username, password: "12345678"} }

    get '/users/edit'
    assert_response :success
    assert assigns(:user)
    assert_equal assigns(:user), @user

    assert_select "input[id=?]", "user_username"
    assert_select "input[id=?]", "user_email"
    assert_select "input[id=?]", "user_password"
    assert_select "input[id=?]", "user_password_confirmation"
    assert_select "input[id=?]", "user_current_password"
    assert_select "input[value=?]", "Atualizar"

  end
end
