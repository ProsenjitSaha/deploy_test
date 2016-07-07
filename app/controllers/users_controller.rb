class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id).all
  end

  def show
    @user = User.find(params[:id])
    @locations = current_user == @user ? current_user.locations : @user.visible_locations(current_user)
  end
end
