class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    redirect_to root_path if signed_in?
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Bookboard!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end