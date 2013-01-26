class AuthenticationController < ApplicationController
  def sign_up
    @user = User.new
  end

  def sign_in
  end

  def log_in
    @user = User.where(email: params[:email]).first

    if @user.try(:password) == params[:password]
      session[:user_id] = @user.id

      return redirect_to root_path
    end

    render :sign_in
  end

  def sign_out
    session.delete(:user_id)

    redirect_to root_path
  end
end
