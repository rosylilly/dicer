class ItemsController < ApplicationController
  before_filter :require_login!, only: %w(new create edit update destroy)

  def show
    @item = Item.find(params[:id].to_i).decorate
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.create!(params[:item])

    redirect_to item_path(@item)
  rescue Activrecord::RecordInvalid
    render :new
  end
end
