class FavoriteList < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :rates, as: :ratable, dependent: :destroy
  belongs_to :user
end
