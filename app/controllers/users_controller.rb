class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def main
    @shoe = Shoe.new
    @shoes = Shoe.all
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      if signed_in? and current_user.admin?
        redirect_to dashboard_path, flash: { success: "User created" }
      else
  		  redirect_to login_path, flash: { message: "Registration succesfull, please log in" }
      end
  	else
  		redirect_to register_path, flash: { errors: @user.errors.full_messages }
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
  	@user = User.find(params[:id])
  end

  def add_user
  	@user = User.new
  end

  def destroy
  	@user = User.find(params[:id])
    if current_user?(@user)
      flash[:error] = "Can't delete self"
    else
      @user.destroy
      flash[:success] = "User deleted."
    end
    redirect_to dashboard_path
  end

  private

  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def admin_user
  	redirect_to root_path unless current_user.admin?
  end

  def signed_in_user
    redirect_to login_path, notice: "Please sign in." unless signed_in? 
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless (current_user?(@user) or current_user.admin?)
  end
end