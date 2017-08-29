class CheckoutsController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery

  def show
    @order = current_order
    render_wizard
  end

  def update
    @order = current_order
    case step
    when :address
      if @order.get_address("billing").try(:persisted?)
        update_addresses
      else
        create_addresses
      end
      render_addresses_forms
    when :delivery
    end
  end

  private

  def create_addresses
    @order.addresses.new(billing_address_params)
    @order.addresses.new(shipping_address_params) unless params[:billing][:address_type] == "both"
  end

  def update_addresses
    @order.get_address("billing").update(billing_address_params)
    unless params[:billing][:address_type] == "both"
      if @order.addresses.size < 2
        @order.addresses.new(shipping_address_params)
      else
        @order.get_address("shipping").update(shipping_address_params)
      end
    end
  end

  def shipping_address_params
    params.require(:shipping).permit(:first_name, :last_name, :address_name, :city, :zip, :country, :phone, :address_type))
  end

  def billing_address_params
    params.require(:billing).permit(:first_name, :last_name, :address_name, :city, :zip, :country, :phone, :address_type)
  end

  def render_addresses_forms
    if @order.get_address("billing").errors.any? || @order.get_address("shipping").errors.any?
      render_wizard
    else
      render_wizard @order
    end
  end
end
