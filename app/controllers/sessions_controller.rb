class SessionsController < ApplicationController
 
  def create
  	user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])
  	if user == false || user.nil?
  		redirect_to login_path, flash: { message: "Incorrect email/password" }
  	else
  		sign_in(user)
  		redirect_to root_path(user)
  	end
  end

  def new
  	@user = User.new
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
end
