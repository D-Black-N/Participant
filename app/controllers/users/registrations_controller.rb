# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.new(parse_params)
    if @user.save
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: 'Пользователь успешно создан'}
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_registration_path, notice: 'Пользователь не создан. Ошибка ввода'}
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   @user = current_user.update(update_params)
  #   if @user
  #     respond_to do |format|
  #       format.html { redirect_to root_url, notice: 'Аккаунт успешно обновлен'}
  #     end
  #   else
  #     respond_to do |format|
  #       format.html { redirect_to edit_user_registration_path, notice: 'Аккаунт не обновлен'}
  #     end
  #   end
  # end

  # DELETE /resource
  # def destroy
  # 
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

   protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :surname, :middlename, :current_user, :password, :password_confirmation])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
    def parse_params
      params.require(:user).permit(:name, :surname, :email, :password, :key_role, :password_confirmation)
    end

    # def update_params
    #   params.require(:user).permit(:name, :surname, :middlename,:email, :key_role, :password, :password_confirmation)
    # end
end
