class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    @user.save!
    session[:user_id] = @user.id

    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    render 'authentication/sign_up'
  end
end
