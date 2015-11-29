class AdminController < ApplicationController
  before_filter :admin_user

  def index
  end

  def update_settings
    mm_o = StuHubSettings.maintenance_mode

    # Maintenance Mode
    StuHubSettings.maintenance_mode = params[:stu_hub_settings][:maintenance_mode] == "1" ? true : false
    StuHubSettings.maintenance_message = params[:stu_hub_settings][:maintenance_message]

    flash[:success] = "Successfully applied settings."
    if params[:stu_hub_settings][:maintenance_mode] != mm_o
      flash[:info] = "Maintenance Mode is now #{StuHubSettings.maintenance_mode ? "ON" : "OFF"}"
    end
    redirect_to admin_path
  end

  def user_management
    @users = User.paginate(page: params[:page], per_page: 25).order('created_at ASC')
  end

  private

  # ensure admin or superuser
  def admin_user
    unless current_user.admin?
      flash[:danger] = "You do not have the permission to do that."
      redirect_to home_path
    end
  end

  # ensure superuser only
  def super_user
    unless current_user.super_user?
      flash[:danger] = "You do not have the permission to do that."
      redirect_to home_path
    end
  end
end
