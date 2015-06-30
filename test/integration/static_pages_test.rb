require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  def setup
  	@page  = pages(:about)
    @pages = Page.order(:name)
  end

  test "should get page about" do
    get '/about'
    assert_response :success
    assert assigns(:page)
    assert_template 'static_pages/index'
  end

  test "should return excpection when page not found" do
    get '/nothing'    
    assert_response :not_found    
  end

  test "should convert markdown to html" do
    get '/contato'    
    assert_response :success
    assert_select 'h3', 'Contato'
    assert_select 'em', 'contato'
  end

  # test "should show the permalinks at homepage" do
  #   get root_path

  #   assert_select "li.dropdown ul.dropdown-menu" do |elements|
  #     assert_equal @pages.size, elements.size
      
  #     names = @pages.map(&:name)

  #     elements.each_with_index do |index, element|
  #       puts index
  #       assert_select element, 'li', text: names[index]
  #     end
  #   end

  # end

end
