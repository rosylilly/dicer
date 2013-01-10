class BookStoreController < ApplicationController
  def show
    book = Book.find(params[:id])

    render :nothing => true
  end

  context_for :purchase, BookStorePurchaseContext
  def purchase
    book = Book.find(params[:id])
    user = User.find(session[:user_id])

    user = user.in_context if defined?(Mongoid)

    user.purchase(book)

    if user.purchased?
      render :nothing => true, :status => 201
    else
      render :nothing => true, :status => 403
    end
  end
end
