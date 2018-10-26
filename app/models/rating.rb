class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :ratable, polymorphic: true
  
  class << self
    def find_rating user, rating_params
      where(ratable_id: rating_params[:ratable_id], 
        ratable_type: rating_params[:ratable_type]).first_or_create do |rating|
          rating.user_id = user.id
          rating.ratable_id = rating_params[:ratable_id]
          rating.ratable_type = rating_params[:ratable_type]
          rating.point = rating_params[:point]
      end
    end
    
    def avg_rating ratable_id, ratable_type
      where(ratable_id: ratable_id, ratable_type: ratable_type).average(:point)
    end
  end
end
