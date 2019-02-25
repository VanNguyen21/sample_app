class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_user, excpet: [:new, :index, :user_params,
    :logged_in_user, :admin_user]
  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t "pls_check_mail"
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "deleted"
    redirect_to users_url
  end

  def edit; end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "profile_update"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
    .permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def find_user
    @user = User.find_by id :params[:id]
    return if @user
    flash[:danger] = t "please_login"
    redirect_to root_path
  end
end
