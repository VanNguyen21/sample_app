class UsersController < ApplicationController
  def show
    @user = User.find(param[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user)
    .permit :name, :email, :password, :password_confirmation
  end
end
