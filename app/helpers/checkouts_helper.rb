module CheckoutsHelper
  def has_error?(type, field)
    address = @order.get_address(type)
    address.errors.include?(field) if address
  end

  def error_message(type, field)
    address = @order.get_address(type)
    address.errors.messages[field][0] if address
  end

  def saved_value(type, field)
    address = @order.get_address(type)
    address[field] if address
  end

  def use_billing_address?
    address = @order.get_address("billing")
    address.address_type == "both" if address
  end
end
