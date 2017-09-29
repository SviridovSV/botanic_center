class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def current_order
    Order.find_or_initialize_by(id: session[:order_id])
  end

  private

  def save_user_to_order
    @order = current_order
    return unless @order.persisted?
    @order.user = current_user
    @order.save
  end

  def save_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
