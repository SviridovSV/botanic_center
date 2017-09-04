class CheckoutsController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_user!
  before_action :check_empty_cart

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @order = current_order
    save_user_to_order unless @order.user
    if step == :complete
      CheckoutMailer.complete_email(current_user, @order).deliver_now
      session.delete(:order_id)
    end
    render_wizard
  end

  def update
    @steps = steps
    @order = current_order
    case step
    when :address
      if @order.get_address('billing').try(:persisted?)
        update_addresses
      else
        create_addresses
      end
      render_addresses_forms
    when :delivery
      render_delivery_form
    when :payment
      save_or_update_card
      render_wizard @order.credit_card
    when :confirm
      @order.confirm
      render_wizard @order
    end
  end

  private

  def save_or_update_card
    if @order.credit_card.try(:persisted?)
      @order.credit_card.update(credit_card_params)
    else
      @order.create_credit_card(credit_card_params)
    end
    @order.save
  end

  def create_addresses
    @order.addresses.new(billing_address_params)
    @order.addresses.new(shipping_address_params) unless params[:billing][:address_type] == 'both'
  end

  def update_addresses
    @order.get_address('billing').update(billing_address_params)
    unless params[:billing][:address_type] == 'both'
      if @order.addresses.size < 2
        @order.addresses.new(shipping_address_params)
      else
        @order.get_address('shipping').update(shipping_address_params)
      end
    end
  end

  def shipping_address_params
    params.require(:shipping).permit(:first_name, :last_name, :address_name, :city, :zip, :country, :phone, :address_type)
  end

  def billing_address_params
    params.require(:billing).permit(:first_name, :last_name, :address_name, :city, :zip, :country, :phone, :address_type)
  end

  def credit_card_params
    params.require(:credit_card).permit(:card_number, :name_on_card, :mm_yy, :cvv)
  end

  def render_addresses_forms
    if @order.get_address("billing").errors.any? || @order.get_address("shipping").errors.any?
      render_wizard
    else
      render_wizard @order
    end
  end

  def render_delivery_form
    if params[:delivery]
      @order.delivery_id = params[:delivery]
      render_wizard @order
    else
      render_wizard
    end
  end

  def save_user_to_order
    @order.user = current_user
    @order.save
  end

  def check_empty_cart
    redirect_to cart_path, alert: 'Cart is empty' if current_order.order_items.count == 0
  end
end
