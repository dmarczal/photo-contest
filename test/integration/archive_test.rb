require 'test_helper'
require "application_helper"
include ActionView::Helpers::DateHelper
include ApplicationHelper

class ArchiveTest < ActionDispatch::IntegrationTest

	def setup
		time = Time.now - 1.month
		@contest = FactoryGirl.build :contest, opening_enrollment: time, closing_enrollment: time + 2.weeks, opening: time + 2.weeks, closing: time + 1.month
		@contest.save validate: false
		@contests = Contest.old
		
		FactoryGirl.create_list :participant, 3, contest: @contest, status: 2 do |participant|
			FactoryGirl.create_list :vote, 3, participant: participant
		end
	end

	test "should get archives page" do
		get '/contests/archive'
	    assert_response :success
	    assert assigns(:contests)

		contests = @contests.paginate(page: 1, per_page: 9) 

	    contests.each do |contest|
	    	assert_select "img[alt=?]", contest.title

	    	assert_select "p.title" do
				assert_select "b", text: contest.title
      		end

      		assert_select "p.close-at", "Concurso encerrado há #{format_date_old(contest.closing)}"
      		assert_select "div.winners > p", count: 3
    		assert_select "a[href=?]", contest_path(contest)
    	end
	end
end
