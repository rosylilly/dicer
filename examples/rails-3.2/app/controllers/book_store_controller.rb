class BookStoreController < ApplicationController
  def show
    book = Book.find(params[:id])

    render :nothing => true
  end

  def purchase
    set_context BookStorePurchaseContext.new

    book = Book.find(params[:id])
    user = User.where(:id => session[:user_id]).first.in_context

    user.purchase(book)

    render :nothing => true, :status => 201
  end
end
