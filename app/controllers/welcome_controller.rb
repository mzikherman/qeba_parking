class WelcomeController < ApplicationController
  # Main page, check-in and check-out
  def index
    @occupied_spots = Visit.occupied.count
    @total_members = Owner.count
    @notice = params[:flash]
  end
end
