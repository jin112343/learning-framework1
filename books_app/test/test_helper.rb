ENV['RAILS_ENV'] ||= 'test'
ENV['BOOKS_ADMIN_USER'] = 'test-owner'
ENV['BOOKS_ADMIN_PASSWORD'] = 'test-only-password'
require_relative '../config/environment'
require 'rails/test_help'
class ActiveSupport::TestCase
  fixtures :all
end
class ActionDispatch::IntegrationTest
  def admin_headers
    { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('test-owner', 'test-only-password') }
  end
end
