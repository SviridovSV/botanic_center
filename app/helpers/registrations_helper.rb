module RegistrationsHelper
  def is_tab?(tab)
    return true if !params.has_key?(:tab) && tab == "address"
    params[:tab] == tab
  end
end
