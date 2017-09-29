module RegistrationsHelper
  def is_tab?(tab)
    return true if !params.has_key?(:tab) && tab == 'address'
    params[:tab] == tab
  end

  def form_has_error?(type, field)
    return unless correct_type?(type)
    @address.errors.include?(field)
  end

  def form_error_message(type, field)
    return unless correct_type?(type)
    @address.errors.messages[field][0] if @address
  end

  def form_saved_value(type, field)
    address = current_user.get_address(type)
    return @address[field] if @address.try(:[], field) && correct_type?(type)
    address[field] if address
  end

  private

  def correct_type?(type)
    @address.try(:address_type) == type
  end
end
