class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy, :index]
  before_action :existing_user,  only: [:new, :create]
  before_action :correct_user,   only: [:edit, :update]
  before_action :manage_user,    only: :destroy
  before_action :admin_user,     only: :index
  
  def new
    @user = User.new
  end

  def create
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
    if signed_in?
      @book = current_user.books.build
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if current_user?(@user)
      @user.destroy
      flash[:success] = "Account deleted, thanks for trying Bookboard!"
    else # User is an admin
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
    end
    redirect_to(root_url)
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
    end

    # Before filters

    def existing_user
      redirect_to(current_user) if signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def manage_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end
end