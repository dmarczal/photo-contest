require 'test_helper'

class VotingTest < ActionDispatch::IntegrationTest

  def setup
    @contest = FactoryGirl.build (:contest)
    @contest.opening_enrollment = Time.now
    @contest.closing_enrollment = Time.now + 1.day
    @contest.opening = Time.now
    @contest.closing = Time.now + 2.days
    @contest.save(validate:false)
    @user = FactoryGirl.build(:user)
    @user.name = "Helbert"
    @user.username = "helbert"
    @user.password = "12345678"
    @user.password_confirmation = "12345678"
    @user.save!
    @participant1 = FactoryGirl.create :participant, contest: @contest, status: 1
    @participant2 = FactoryGirl.create :participant, contest: @contest, status: 1
    @contests = Contest.all
  end

   def login
     get '/users/sign_in'
     post '/users/sign_in', {user: { login: @user.username,
                                     password: "12345678"} }

     follow_redirect!
   end

  test "should do the login before to vote" do
    get "/contests/#{@contest.id}"
    assert_response :success
    assert assigns(:contest)
    get "/vote/#{@participant1.id}"
    follow_redirect!
    assert_equal 'Efetue seu login para votar no concurso!', flash[:danger]
  end

   test "success vote" do
     login
     get "/contests/#{@contest.id}"
     assert_response :success
     assert assigns(:contest)
     get "/vote/#{@participant1.id}"
     assert_equal 'Voto registrado. Você pode votar uma única vez em cada concurso.', flash[:success]
   end

   test "contest already voted" do
     login
     get "/contests/#{@contest.id}"
     assert_response :success
     assert assigns(:contest)
     get "/vote/#{@participant1.id}"
     assert_equal 'Voto registrado. Você pode votar uma única vez em cada concurso.', flash[:success]
     get "/contests/#{@contest.id}"
     assert_response :success
     get "/vote/#{@participant1.id}"
     assert_equal 'Você já votou neste concurso.', flash[:danger]
   end

end
