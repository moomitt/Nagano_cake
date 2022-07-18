class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if params[:order_detail][:making_status] == "making"
      @order.update(status: "making")
    end
    if @order.order_details.count == @order.order_details.where(making_status: "finish").count
      @order.update(status: "preparing_delivery")
    end
    redirect_to admin_order_path(@order.id)
  end
  
  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
end
