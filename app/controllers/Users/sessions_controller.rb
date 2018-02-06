# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end
  def after_sign_in_path_for(resource)
    # # '/order/new' # Or :prefix_to_your_route
    me = current_user
    @user = User.find(me)
    path= "/users/"+@user.id.to_s+"/order"
    path
    # redirect_to user_orders_path
  end
  def after_sign_out_path_for(resource)
    '/' # Or :prefix_to_your_route
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  # def create
  #   super do |resource|
  #     BackgroundWorker.trigger(resource)
  #   end
  # end
end
