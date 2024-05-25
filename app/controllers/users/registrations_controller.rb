class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:admin_password, :editor_password])
  end

  def update_resource(resource, params)
    set_user_role(resource)
    super
  end

  private

  def set_user_role(resource)
    if params[:user][:admin_password] == "cat"
      resource.role = :admin
    elsif params[:user][:editor_password] == "dog"
      resource.role = :editor
    else
      resource.role = :user
    end
  end
end
