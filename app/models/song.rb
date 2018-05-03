class Song < ApplicationRecord
  has_many :lysics, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_lists, through: :favorites
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :rates, as: :ratable, dependent: :destroy
  belongs_to :artist
  belongs_to :album
end
