class SessionsController < Devise::SessionsController
  after_action :save_user_to_order, only: :create
end
