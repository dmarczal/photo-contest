require 'test_helper'
require 'minitest/autorun'

class HomeTest < ActionDispatch::IntegrationTest

  def setup
    @contests = FactoryGirl.create_list :old_contests, 3
    @about_page = FactoryGirl.create :about_page
    @contact_page = FactoryGirl.create :contact_page
    @user = FactoryGirl.build(:user)
    @user.name = "Helbert"
    @user.username = "helbert"
    @user.password = "12345678"
    @user.password_confirmation = "12345678"
    @user.save!
  end


  test "idex page"do
    get root_path
    assert :success

      @contests.each do |contest|
        assert_select ".row.contest_old" do
          assert_select "img", alt: contest.title
          assert_select ".col-xs-12.col-sm-9" do |elements|
            elements.each do |elem|
              assert_select "b", text: contest.title
              assert_select "p", 9 #, text: /format_date_old(@contest.closing/
              assert_select "a[href=?]", contest.id
            end
          end
        end
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
