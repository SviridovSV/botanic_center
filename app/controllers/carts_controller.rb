class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
  end

  def update
    @coupon = Coupon.find_by_code(params[:coupon_code])
    @order = current_order
    if @coupon
      @order.coupon = @coupon.discount
      @order.save
      redirect_to cart_path, notice: 'Coupon was activated.'
    else
      redirect_to cart_path, alert: 'Wrong coupon code.'
    end
  end
end
