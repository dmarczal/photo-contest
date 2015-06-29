require 'test_helper'

class PageTest < ActiveSupport::TestCase
  should validate_uniqueness_of :permalink  
end
