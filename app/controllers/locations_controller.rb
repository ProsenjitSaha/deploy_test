class LocationsController < ApplicationController
  def create
    @user = current_user
    @location = @user.locations.find(params[:location].delete(:id)) if params[:location][:id].present?
    @location ||= @user.locations.build

    if @location.update_attributes(location_params)
      @locations = current_user.locations
      @friends = @user.mutual_friends if params[:commit] =~ /share/i
      @shared_locations_friend_id = @location.shared_locations.pluck(:friend_id)
      render layout: false
    end
  end

  def share
    location = current_user.locations.find(params[:id])

    if params[:location] && params[:location][:friend_ids].present?
      location.shared_with_users = User.find(params[:location].delete(:friend_ids))
    else
      location.shared_locations.destroy_all
    end

    redirect_to current_user, notice: "Location has successfully shared with your friend(s)."
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude, :public)
  end
end
