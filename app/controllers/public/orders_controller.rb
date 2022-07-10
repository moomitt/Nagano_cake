class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @total_payment = @total_price.to_i + 800
  end
  
  def create
    @order = Order.new(order_params)
    @total_payment = @total_price.to_i + 800
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
    redirect_to orders_confirm_path
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