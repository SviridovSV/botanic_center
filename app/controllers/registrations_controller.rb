class RegistrationsController < Devise::RegistrationsController
  def address_settings
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    @address = Address.find_by(user_id: params[:address][:user_id],
                               address_type: params[:address][:address_type])
    @address ? update_address : create_address
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :last_name, :address_name, :city, :zip,
                                    :country, :phone, :address_type, :user_id)
  end

  def update_address
    if @address.update(address_params)
      redirect_to edit_user_registration_path, notice: "Your account has been updated successfully."
    else
      render "edit"
    end
  end

  def create_address
    @address = Address.new(address_params)
    if @address.save
      redirect_to edit_user_registration_path, notice: "Your account has been updated successfully."
    else
      render "edit"
    end
  end

  protected

  def update_resource(resource, params)
    if params.include?(:current_password)
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end

  def after_update_path_for(resource)
    edit_user_registration_path(tab: params[:tab])
  end
end
