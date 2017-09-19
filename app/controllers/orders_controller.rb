class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :show

  def index
    @orders = SortOrdersService.new(params[:sort_type], current_user.orders).sort_orders
  end

  def show
  end

  def continue_shopping
    session[:order_id] = params[:id]
    redirect_to category_path(1)
  end

  private

  def correct_user
    @order = current_user.orders.find_by(id: params[:id])
    redirect_to root_url if @order.nil?
  end
end
