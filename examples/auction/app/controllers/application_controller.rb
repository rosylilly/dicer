class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: 404
  end

  rescue_from Auction::RequireLogin do
    render nothing: true, status: 403
  end

  def logined?
    context.logined?
  end
  private :logined?
  helper_method :logined?

  def current_user
    context.current_user
  end
  private :current_user
  helper_method :current_user

  def require_login!
    raise Auction::RequireLogin unless logined?
  end
  private :require_login!
end
