require 'test_helper'
require 'minitest/autorun'

class HomeTest < ActionDispatch::IntegrationTest

  def setup
    @about_page = FactoryGirl.create :about_page
    @contact_page = FactoryGirl.create :contact_page

    @contest = FactoryGirl.build :contest
    @contest.save validate: false

    @old_contest = FactoryGirl.build :old_contest
    @old_contest.save validate: false

    @current_contest = FactoryGirl.build :current_contest
    @current_contest.save validate: false

    @user = FactoryGirl.build(:user)
    @participant = FactoryGirl.create :participant
  end


  test "layout page" do
        get root_path
        assert :success
        assert_select ".col-xs-12.col-sm-4.image" do
          assert_select "img", alt: @current_contest.title
        end
        assert_select ".col-xs-12.col-sm-8.current-contest" do |elements|
          elements.each do |elem|
            assert_select "b", text: @current_contest.title
            assert_select "p", 3
            assert_select "a[href=?]", contest_path(@current_contest.id)
          end
        end


        assert_select ".row.contest_old" do
          assert_select "img", alt: @old_contest.title
            assert_select ".col-xs-12.col-sm-9" do |elements|
              elements.each do |elem|
                assert_select "b", text: @old_contest.title
                assert_select "p", 3
                assert_select "a[href=?]", contest_path(@old_contest.id)
            end
          end
        end

    assert_select ".bxslider" do |page|
      assert_select "img[src=?]", @participant.picture.url(:medium)
    end
  end

  test "links page" do
    get root_path
    assert_select "a[href=?]", root_url, count: 3
    assert_select "a[href=?]", contests_path
    assert_select "a[href=?]", photographer_list_url
    assert_select "a[href=?]", contests_archive_path
    assert_select "a[href=?]", "/#{@about_page.permalink}"
    assert_select "a[href=?]", "/#{@contact_page.permalink}"
  end
end
