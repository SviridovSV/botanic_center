class OrderItemsController < ApplicationController
  after_action :save_user_to_order, only: :create
  after_action { current_order.save }

  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    session[:order_id] = @order.id if @order.save
  end

  def update
    @order_item = current_order.order_items.find(params[:id])
    if params[:operation] == 'minus'
      update_order_item(1)
    elsif @order_item.book.in_stock?
      update_order_item(-1)
    else
      redirect_to cart_path, alert: 'Item is out of stock.'
    end
  end

  def destroy
    @order_item = current_order.order_items.find(params[:id])
    @order_item.destroy
    redirect_to cart_path, notice: 'Item deleted.'
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end

  def update_order_item(int)
    @order_item.book.quantity += int
    @order_item.book.save
    @order_item.update_attributes(quantity: params[:quantity])
    redirect_to cart_path, notice: 'Item updated.'
  end
end
