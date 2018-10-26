class RatingsController < ApplicationController
  def create
    if logged_in?
      rating = Rating.find_rating current_user, rating_params
      rating.update_attributes rating_params
      render json: {
        status: :success
      }
    else
      render json: {
        status: :error
      }
    end
  end
  
  private
  
  def rating_params
    params.require(:rating).permit :point, :ratable_type, :ratable_id
  end
end
