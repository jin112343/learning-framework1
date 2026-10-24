class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_owner

  private

  def authenticate_owner
    expected_user = ENV['BOOKS_ADMIN_USER'].to_s
    expected_password = ENV['BOOKS_ADMIN_PASSWORD'].to_s
    return head :service_unavailable if expected_user.empty? || expected_password.empty?

    authenticate_or_request_with_http_basic('Private books') do |user, password|
      valid_user = ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(user), Digest::SHA256.hexdigest(expected_user))
      valid_password = ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(password), Digest::SHA256.hexdigest(expected_password))
      valid_user & valid_password
    end
  end
end
