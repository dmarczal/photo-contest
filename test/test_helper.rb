ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
require "database_cleaner"
require 'simplecov'
require 'factory_girl'
include FactoryGirl::Syntax::Methods

Minitest::Reporters.use!
SimpleCov.start


FactoryGirl.find_definitions

DatabaseCleaner.strategy = :transaction
class ActiveSupport::TestCase
	def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end
