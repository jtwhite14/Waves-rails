class APIController < ApplicationController
  respond_to :json
  protect_from_forgery with: :null_session

  before_filter :authenticate_user_from_token!, :except => [:page_not_found]
  before_filter :authenticate_user!

  def authenticate_user_from_token!
    user_token = request.headers["HTTP_AUTHORIZATION"].presence
    Rails.logger.info user_token
    Rails.logger.info "----------"
    user = user_token && User.find_by(authentication_token: user_token)
    sign_in(user) if user
  rescue
    # find_by fails with an invalid token
  end

end