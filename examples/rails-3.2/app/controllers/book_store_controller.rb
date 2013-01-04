class BookStoreController < ApplicationController
  def show
    book = Book.find(params[:id])

    render :nothing => true
  end

  def purchase
    set_context BookStorePurchaseContext.new

    book = Book.find(params[:id])
    user = User.find_by_id(session[:user_id]).in_context

    user.purchase(book)

    if user.purchased?
      render :nothing => true, :status => 201
    else
      render :nothing => true, :status => 403
    end
  end
end
