class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total_price = 0
  end
  
  def confirm
    @order = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    total_price = 0
    @cart_items.each do |cart_item|
      total_price += cart_item.subtotal
    end
    @order.total_price = total_price
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.save
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      @order.save
    else
      @order.save
    end
    render :confirm
  end
  
  def create
    
  end
  
  def complete
  end

  def index
  end

  def show
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :total_price,
    :payment_method, :postal_code, :address, :name)
  end
  
end