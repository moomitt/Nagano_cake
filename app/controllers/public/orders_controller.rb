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
    @order.total_price = total_price + 800
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.save
    cart_items = CartItem.where(customer_id: current_customer.id)
    cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.with_tax_price
      @order_detail.save
    end
    CartItem.where(customer_id: current_customer.id).destroy_all
    redirect_to orders_complete_path
  end
  
  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
    @order_datails = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @order_datails = OrderDetail.where(order_id: @order.id)
  end
  
  def destroy
   @order = Order.find(params[:id])
   @order.destroy
  end
  
  private
  def order_params
    params.require(:order).permit(:id, :customer_id, :postage, :total_price,
    :payment_method, :postal_code, :address, :name)
  end
  
end