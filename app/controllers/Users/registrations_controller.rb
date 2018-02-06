# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :configure_sign_up_params, :only => [:create]


  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_filter  :configure_permitted_parameters, if: :devise_controller?
  # private
  #
  # def sign_up_params
  #   params.require(:user).permit(:first_name, :email, :password, :password_confirmation)
  # end

  # def account_update_params
  #   params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :current_password)
  # end

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create

    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end



  # If you have extra params to permit, append them to the sanitizer.
  # protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstName])
  end
  def after_sign_up_path_for(resource)
    # '/order/new' # Or :prefix_to_your_route
    me = current_user
    @user = User.find(me)
    path= "/users/"+@user.id.to_s+"/order"
    path
  end
  def after_sign_out_path_for(resource)
    '/' # Or :prefix_to_your_route
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  # protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstName) }
  # end

end
