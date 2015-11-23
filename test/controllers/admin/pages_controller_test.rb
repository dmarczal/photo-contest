require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @page = FactoryGirl.create :page

    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:admin_user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      post :create, page: { content: @page.content, name: @page.name, permalink: 'sobre-nos' }
    end
    
    assert_redirected_to admin_page_path(assigns(:page))
  end

  test "should show admin_page" do
    get :show, id: @page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page
    assert_response :success
  end

  test "should update page" do
    patch :update, id: @page, page: { content: @page.content, name: @page.name, permalink: @page.permalink }
    assert_redirected_to admin_page_path(assigns(:page))
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete :destroy, id: @page
    end

    assert_redirected_to admin_pages_path
  end
end
