require 'test_helper'

class ContestTest < ActiveSupport::TestCase  
  
  should validate_presence_of(:title)
  should validate_presence_of(:description)  
  should validate_presence_of(:opening_enrollment)
  should validate_presence_of(:closing_enrollment)
  should validate_presence_of(:opening)
  should validate_presence_of(:closing)

  def setup
  	@contest = FactoryGirl.create :contest
  end

  test 'dates opening should be minor or equals yours closings' do
  	@contest.opening_enrollment = Time.now
    @contest.closing_enrollment = 1.day.ago

    @contest.opening            = Time.now + 2.days    
    @contest.closing            = Time.now + 1.day 

    @contest.save

    assert @contest.errors.any?
    assert @contest.errors.include? :opening_enrollment
    assert @contest.errors.include? :opening
  end

  test 'dates should be bigger or equal than today' do
  	yesterday = Time.now - 1.day

  	@contest.opening_enrollment = yesterday
    @contest.closing_enrollment = yesterday

    @contest.opening            = yesterday
    @contest.closing            = yesterday

    @contest.save

    assert @contest.errors.any?
    assert @contest.errors.include? :opening_enrollment
    assert @contest.errors.include? :opening
    assert @contest.errors.include? :closing_enrollment
    assert @contest.errors.include? :closing

  end

end
