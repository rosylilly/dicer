class ApplicationController < ActionController::Base
  protect_from_forgery

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
