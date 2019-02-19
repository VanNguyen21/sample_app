class UsersController < ApplicationController
  def show
    @user = User.find(param[:id])
  end

  def new; end
end
