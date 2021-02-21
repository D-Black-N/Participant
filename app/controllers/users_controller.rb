class UsersController < ApplicationController

  def all
    @users = User.all
  end

  def index
    if current_user.nil?
      redirect_to inform_view_path
    elsif current_user.key_role == 'student' 
      @student = Progress.where(name: current_user.name, surname: current_user.surname)
    end
  end

  def destroy 
    p @user = User.find_by_id(params[:id])
    @user.delete
    respond_to do |format|
      format.html { redirect_to users_all_url, notice: 'User was successfully destroyed'}
      format.json { render json: 'user destroyed'}
      format.js  
    end
  end
end
