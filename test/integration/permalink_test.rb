require 'test_helper'

class PermalinkTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin_user = FactoryGirl.build(:admin_user)
    @admin_user.name = "Helbert"
    @admin_user.email = "helbert@email.com"
    @admin_user.password = "12345678"
    @admin_user.password_confirmation = "12345678"
    @admin_user.save!
    @about_page = FactoryGirl.create(:about_page)
    @contact_page = FactoryGirl.create(:contact_page)
  end

  test "should do not remove about page" do
    get '/admin/login'
    post '/admin/login', {session: { login: @admin_user.email,
                                    password: "12345678"} }
    get admin_page_path
    assert_response :success
    #@about_page = FactoryGirl.create(:about_page)
    #delete '/admin/pages/1' #id: @about_page.id
    delete admin_page_path(@about_page.id)
    follow_redirect!
    assert_equal 'Esta página não pode ser excluída.', flash[:notice]
  end

  test "should do not remove contact page" do
    get '/admin/login'
    post '/admin/login', {session: { login: @admin_user.email,
                                     password: "12345678"} }
    get admin_page_path
    assert_response :success
    delete admin_page_path(@contact_page.id)
    follow_redirect!
    assert_equal 'Esta página não pode ser excluída.', flash[:notice]
  end
end
