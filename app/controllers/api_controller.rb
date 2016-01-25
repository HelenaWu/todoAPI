class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  private
  def authenticated?
    authenticate_or_request_with_http_basic do |email, password|
      user = User.find_by_email(email)
      if user
        user.authenticate(password)
        session[:user_id] = user.id
      else
        false
      end
    end
  end
end
