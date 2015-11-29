require 'test_helper'

class Admin::ContestsTest < ActionDispatch::IntegrationTest

  def setup
    @contest = FactoryGirl.create :contest
    @user = FactoryGirl.create :admin_user
    @participant_pending = FactoryGirl.create :participant, contest: @contest, status: 0
    @participant_approved = FactoryGirl.create :participant, contest: @contest, status: 1
    @participant_failed = FactoryGirl.create :participant, contest: @contest, status: 2
    @contests = Contest.all
  end

  def login
    post_via_redirect "/admin/login", session: {email: @user.email, password: "123123123"}
  end

  test "index page" do
    login
    get '/admin/contests'
    assert_response :success
    assert assigns(:contests)
    assert_select "th", text: "Título"
    assert_select "th", text: "Abertura"
    assert_select "th", text: "Encerramento"
    assert_select "th", text: "Opções"
    assert_equal assigns(:contests), @contests
    assert_template 'admin/contests/index'
  end

  test "show page" do
    login
    get "/admin/contests/#{@contest.id}"
    assert_response :success
    assert assigns(:contest)
    assert_equal assigns(:contest), @contest
    assert_select "p", text: @contest.description
    assert_select "a[data-target=?]", "#modal-#{@participant_failed.id}"
    assert_select "a[data-target=?]", "#modal-#{@participant_approved.id}"
    assert_select "a[data-target=?]", "#modal-#{@participant_pending.id}"
  end

  test "edit page" do
    login
    get "/admin/contests/#{@contest.id}/edit"
    assert_response :success
    assert assigns(:contest)
    assert_equal assigns(:contest), @contest
    assert_select "input[class=?]", "string datetime_picker required   form-control", count: 4
    assert_select "input[id=?]", "contest_opening"
    assert_select "input[id=?]", "contest_opening_enrollment"
    assert_select "input[id=?]", "contest_closing_enrollment"
    assert_select "input[id=?]", "contest_closing"
    assert_select "input[id=?]", "contest_image"
    assert_select "textarea[id=?]", "contest_description"
    assert_select "input[id=?]", "contest_title"
  end

  test "new page" do
    login
    get "/admin/contests/new"
    assert_response :success
    assert assigns(:contest)
    assert_select "input[class=?]", "string datetime_picker required   form-control", count: 4
    assert_select "input[id=?]", "contest_opening"
    assert_select "input[id=?]", "contest_opening_enrollment"
    assert_select "input[id=?]", "contest_closing_enrollment"
    assert_select "input[id=?]", "contest_closing"
    assert_select "input[id=?]", "contest_image"
    assert_select "textarea[id=?]", "contest_description"
    assert_select "input[id=?]", "contest_title"
  end
end
