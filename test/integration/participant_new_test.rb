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

    def new_participant
   		post "/participants", {participant: 
			{
				title: "Phasellus placerat nisi enim", 
				description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 
				picture: fixture_file_upload('test/factories/img/test.png', 'image/png'),
				accepted_term: 1,
				contest_id: @contest.id
			}
		}
    end

    

    test "unregistered user" do
   		get "/participants/new?contest_id=#{@contest.id}"
		assert_redirected_to "/users/sign_in"
		get "/users/sign_up"
		assert_response :success
		assert_difference "User.count", 1 do
			post "/users", {user:
				{
					username: "loremIpsum",
					name: "Lorem Ipsum",
					short_description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
					biography: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
					email: "lorem@ipsum.com",
					password: "loremipsum",
					password_confirmation: "loremipsum"
				}
			}
		end		

		assert_redirected_to "/participants/new?contest_id=#{@contest.id}"

		assert_difference 'Participant.count', 1 do
			new_participant
		end
	end

	test "registered but not logged in" do
		get "/participants/new?contest_id=#{@contest.id}"
		assert_redirected_to "/users/sign_in"
		post '/users/sign_in', {user: 
			{
				login: @user.username,
			 	password: "123123123"
			 }
		}

		assert_redirected_to "/participants/new?contest_id=#{@contest.id}"

		assert_difference 'Participant.count', 1 do
			new_participant
		end
	end

	test "user logged in" do
		login
		get "/contests/#{@contest.id}"
		assert_response :success

		assert_difference 'Participant.count', 1 do
			new_participant
		end
	end

	test "sending data incorrectly" do
		login
		get "/contests/#{@contest.id}"
		assert_response :success

		assert_difference 'Participant.count', 0 do
	   		post "/participants", {participant: 
				{
					title: "", 
					description: "", 
					picture: fixture_file_upload('test/factories/img/test.png', 'image/png'),
					accepted_term: 1,
					contest_id: @contest.id
				}
			}			
		end
	end
end