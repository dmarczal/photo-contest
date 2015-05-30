require 'test_helper'

class Admin::ContestTest < ActiveSupport::TestCase  
  should validate_presence_of(:title)
  should validate_presence_of(:description)
  should validate_presence_of(:folder)
  should validate_presence_of(:opening_enrollment)
  should validate_presence_of(:closing_enrollment)
  should validate_presence_of(:opening)
  should validate_presence_of(:closing)

  def setup
  	@admin_contest = admin_contests(:one)
  end

  test 'dates opening should be minor or equals yours closings' do
  	@admin_contest.opening_enrollment = Time.now
    @admin_contest.closing_enrollment = 1.day.ago

    @admin_contest.opening            = Time.now + 2.days    
    @admin_contest.closing            = Time.now + 1.day 

    @admin_contest.save

    assert @admin_contest.errors.any?
    assert @admin_contest.errors.include? :opening_enrollment
    assert @admin_contest.errors.include? :opening
  end

  test 'dates should be bigger or equal than today' do
  	yesterday = Time.now - 1.day

  	@admin_contest.opening_enrollment = yesterday
    @admin_contest.closing_enrollment = yesterday

    @admin_contest.opening            = yesterday
    @admin_contest.closing            = yesterday

    @admin_contest.save

    assert @admin_contest.errors.any?
    assert @admin_contest.errors.include? :opening_enrollment
    assert @admin_contest.errors.include? :opening
    assert @admin_contest.errors.include? :closing_enrollment
    assert @admin_contest.errors.include? :closing

  end

end