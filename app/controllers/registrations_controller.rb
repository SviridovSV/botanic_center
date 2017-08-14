class RegistrationsController < Devise::RegistrationsController
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
