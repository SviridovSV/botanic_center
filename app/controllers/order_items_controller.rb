class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order.save unless @order.persisted?
    @order_item = @order.order_items.new(order_item_params)
    if @order.valid?
      @order.save
      session[:order_id] = @order.id
    end
  end

  def update
    @order_item = current_order.order_items.find(params[:id])
    if @order_item.quantity > params[:order_item][:quantity].to_i
      update_order_items(1)
    elsif @order_item.book.in_stock?
      update_order_items(-1)
    else
      redirect_to cart_path, alert: "Item is out of stock."
    end
  end

  def destroy
    @order_item = current_order.order_items.find(params[:id])
    @order_item.destroy
    redirect_to cart_path, notice: "Item was deleted."
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end

  def update_order_items(number)
    @order_item.book.quantity += number
    @order_item.book.save
    @order_item.update(order_item_params)
    redirect_to cart_path, notice: "Item was updated."
  end
end
