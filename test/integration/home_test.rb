require 'test_helper'
require 'minitest/autorun'

class HomeTest < ActionDispatch::IntegrationTest

  def setup
    @about_page = FactoryGirl.create :about_page
    @contact_page = FactoryGirl.create :contact_page

    @contest = FactoryGirl.create :contest
    @old_contests = FactoryGirl.create_list :old_contests, 3
    @current_contest = FactoryGirl.create_list :current_contests, 1

    @user = FactoryGirl.build(:user)

    @participant = Participant.create(user_id: @user.id, contest_id: @contest.id)
    @participant.picture =  File.open(Dir["#{Rails.root}/lib/images/participant/*"].sample)
    @participant.save(validate: false)

  end


  test "layout page"do
    get root_path
    assert :success

    @current_contest.each do |current_contest|
        assert_select ".col-xs-12.col-sm-4.image" do
          assert_select "img", alt: current_contest.title
        end

        assert_select ".col-xs-12.col-sm-8.current-contest" do |elements|
          elements.each do |elem|
            assert_select "b", text: current_contest.title
            assert_select "p", 3
            assert_select "a[href=?]", current_contest.id
          end
        end
      end

    @old_contests.each do |old_contest|
        assert_select ".row.contest_old" do
          assert_select "img", alt: old_contest.title
            assert_select ".col-xs-12.col-sm-9" do |elements|
              elements.each do |elem|
                assert_select "b", text: old_contest.title
                assert_select "p", 9
                assert_select "a[href=?]", old_contest.id
            end
          end
        end
      end

    assert_select ".bxslider" do
      assert_select "a[href=?]", @participant.picture.url
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
