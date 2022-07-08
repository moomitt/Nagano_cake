class Public::CartItemsController < ApplicationController

  def create
    binding.pry
    @cart_item = CartItem.new(cart_item_params[:item_id])
    @cart_item.save
    redirect_to root_path
  end


  def index
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
