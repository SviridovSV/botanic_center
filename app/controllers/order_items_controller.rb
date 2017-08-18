class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order.save
    @order_item = @order.order_items.new(order_item_params)
    if @order.save
      session[:order_id] = @order.id
    else
      redirect_to session[:forwarding_url], alert: "Item was not added."
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    redirect_to cart_path, notice: "Item was updated."
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    redirect_to cart_path, notice: "Item was deleted."
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end
