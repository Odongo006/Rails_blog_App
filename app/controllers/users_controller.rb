class UsersController < ApplicationController
  def index
    @users = User.all
    @current_user = current_user
  end

  def show
    @user = User.order(created_at: :desc).find(params[:id])
  end
end
