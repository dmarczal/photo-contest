require 'test_helper'

class PhotographersTest < ActionDispatch::IntegrationTest
  def setup
    FactoryGirl.create_list :user, 20
    User.first.update first: nil
    @photographers = User.all
  end

  test "should get photographers page" do
    photographers = @photographers.paginate(page: 1, per_page: 8)
    get '/photographers/list'
    assert_response :success
    assert assigns(:photographers)

    assert_select "h3" do
      assert_select "a", photographers.first.name
    end

    assert_select "a[href=?]", photographer_path(photographers.first.id)
    assert_select "a.thumbnail" do
      assert_select "img[alt=?]", photographers.first.name
    end

    assert_select "article.small-description", text: /#{photographers.first.short_description}/
    assert_select "span.position-user", text: "0"
    assert_select "span.position-user", text: photographers.first.second.to_s
    assert_select "span.position-user", text: photographers.first.third.to_s
    assert assigns(:photographers), photographers
    assert_template 'photographers/list'

    photographers = @photographers.paginate(page: 2, per_page: 8)
    get '/photographers/list?page=2'

    assert_response :success
    assert assigns(:photographers)
    assert_select "h3" do
      assert_select "a", photographers.first.name
    end

    assert_select "a.thumbnail" do
      assert_select "img[alt=?]", photographers.first.name
    end

    assert_select "article.small-description", text: /#{photographers.first.short_description}/
    assert_select "span.position-user", text: photographers.first.first.to_s
    assert_select "span.position-user", text: photographers.first.second.to_s
    assert_select "span.position-user", text: photographers.first.third.to_s
    assert assigns(:photographers), @photographers.paginate(page: 2, per_page: 8)
    assert_template 'photographers/list'
  end
end
