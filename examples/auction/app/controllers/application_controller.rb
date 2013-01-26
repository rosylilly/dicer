class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: 404
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
end
