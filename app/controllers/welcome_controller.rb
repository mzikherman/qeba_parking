class WelcomeController < ApplicationController
  # Main page, check-in and check-out
  def index
    @occupied_spots = Visit.occupied.count
    
  end
end
