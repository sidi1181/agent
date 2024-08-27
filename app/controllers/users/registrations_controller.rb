class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: %i[create update]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i[name address phone_number role_id]
    )
  end
end