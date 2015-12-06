require 'test_helper'

class ParticipantNewTest < ActionDispatch::IntegrationTest
	def setup
		time = Time.now
		@contest = FactoryGirl.build :contest, opening_enrollment: time, closing_enrollment: time + 2.weeks, opening: time + 2.weeks, closing: time + 1.month
		@contest.save validate: false

		@user = FactoryGirl.create(:user)
	end

   def login
     get '/users/sign_in'
     post '/users/sign_in', {user: { login: @user.username, password: "123123123"}}

     follow_redirect!
   end

	test "should sign up for a new contest" do
		get "/contests/#{@contest.id}"
		assert_response :success
		assert assigns (:contest)
		assert_select "a[href=?]", "/participants/new?contest_id=#{@contest.id}"
		login
		get "/participants/new?contest_id=#{@contest.id}"
		assert_response :success
	end

	test "should inscricao" do
		login
		get "/participants/new?contest_id=#{@contest.id}"
		post "/participants", {participant: 
			{
				title: "Titulofdsfsafsafsaf", 
				description: "descriptionfsdafsafsafsafsafdsafsadfdsaf", 
				picture: fixture_file_upload('test/factories/img/test.png', 'image/png'),
				accepted_term: 1
			}
		}
	end
end
