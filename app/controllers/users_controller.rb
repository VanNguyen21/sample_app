class UsersController < ApplicationController
  def show
    @user = User.find(param[:id])
  end

  def new; end

  def create
    @user = User.new params[:user]
    if @user.save
      flash[:success] = t "welcome"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
