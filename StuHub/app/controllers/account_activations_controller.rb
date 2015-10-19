class AccountActivationsController < ApplicationController
  skip_before_filter :require_login

  def edit
    user = User.find_by(email: params[:email])
    if user.activated?
      flash[:danger] = "This account has already been activated."
      redirect_to root_url
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Your account has been activated."
      UserMailer.welcome_email(user).deliver_now
      redirect_to user
    else
      flash.now[:danger] = "Invalid activation link. Please verify that the link is correct."
      redirect_to root_url
    end
  end
end
