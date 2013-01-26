class AuthenticationController < ApplicationController
  def sign_up
    @user = User.new
  end
end
