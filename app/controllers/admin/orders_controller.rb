class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @order.update(order_params)
    if @order.status == "confirm_payment"
      @order_details.update_all(making_status: "wait_making")
    end
    redirect_to admin_order_path(@order.id)
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end

end
