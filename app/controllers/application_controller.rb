class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
    unless session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  private

  def save_user_to_order
    @order = current_order
    if @order.persisted?
      @order.user = current_user
      @order.save
    end
  end

  def save_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
