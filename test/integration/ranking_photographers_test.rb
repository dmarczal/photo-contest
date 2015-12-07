require 'test_helper'

class RankingPhotographersTest < ActionDispatch::IntegrationTest

  def setup
    FactoryGirl.create_list :user, 29
    @users = User.all
  end

  test "should get contests page" do
    participants = @users.order(first: :desc, second: :desc, third: :desc).paginate(page: 1, per_page: 10)
    get ranking_index_path
    assert_response :success
    assert assigns(:users)

    participants.each do |participant|

      assert_select "td" do
        assert_select "img[alt=?]",  participant.name
      end
      assert_select "td.name-user", text: participant.name
      assert_select "a[href=?]", photographer_path(participant.id)
      assert_select "td", text: participant.short_description
      assert_select "td" do
        assert_select "i" do
          assert_select "span", text: participant.first.to_s
        end
      end
      assert_select "td" do
        assert_select "i" do
          assert_select "span", text: participant.second.to_s
        end
      end
      assert_select "td" do
        assert_select "i" do
          assert_select "span", text: participant.third.to_s
        end
      end
    end
  end

  test "should get paging ranking photographers first page" do
    participants = @users.order(first: :desc, second: :desc, third: :desc).paginate(page: 1, per_page: 10)
    get "/ranking/index"

    assert_select "ul.pagination" do
      assert_select "li", 5
      assert_select "li.active", "1"
    end
  end

  test "should get paging ranking photographers second page" do
    participants = @users.order(first: :desc, second: :desc, third: :desc).paginate(page: 1, per_page: 10)
    get "/ranking/index?page=2"

    assert_select "ul.pagination" do
      assert_select "li", 5
      assert_select "li.active", "2"
    end
  end
end
