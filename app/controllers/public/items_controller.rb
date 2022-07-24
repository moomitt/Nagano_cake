class Public::ItemsController < ApplicationController
  
  def index
    @genres = Genre.all
    @items = Item.page(params[:page]).per(8)
    @all_items = Item.all
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
end
