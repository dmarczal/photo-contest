require 'test_helper'

class ContestsTest < ActionDispatch::IntegrationTest
  def setup
    FactoryGirl.create_list :contest, 20
    @contests = Contest.all
  end

  test "should get contests page" do
    contests = @contests.paginate(page: 1, per_page: 9)
    get '/contests'
    assert_response :success
    assert assigns(:contests)

    contests.each do |contest|

      assert_select "p.title" do
        assert_select "b", text: contest.title
      end

      assert_select "a.thumbnail[href=?]", contest.id

      assert_select "a.thumbnail" do
        assert_select "img[alt=?]", contest.title
      end

      assert_select "p.opening_enrollment" do
        assert_select "b", text: contest.opening_enrollment.strftime("%d/%m/%Y - %H:%M")
      end

      assert_select "p.closing_enrollment" do
        assert_select "b", text: contest.closing_enrollment.strftime("%d/%m/%Y - %H:%M")
      end

      assert_select "a.link_contest[href=?]", contest.id
    end
  end

  test "should get paging contests first page" do
    contests = @contests.paginate(page: 1, per_page: 9)
    get '/contests'

    assert_select "ul.pagination" do
      assert_select "li", 5
      assert_select "li.active", "1"
    end
  end

  test "should get paging contests second page" do
    contests = @contests.paginate(page: 1, per_page: 9)
    get '/contests?page=2'

    assert_select "ul.pagination" do
      assert_select "li", 5
      assert_select "li.active", "2"
    end
  end
end
