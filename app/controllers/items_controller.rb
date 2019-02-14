class ItemsController < ApplicationController

  def index
    @items = Item.where(active: true)
  end

  def show
    @item = Item.find(params[:id])
    @cart
  end

end
