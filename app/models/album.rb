class Album < ApplicationRecord
  has_many :songs, dependent: :destroy
  belongs_to :category
  belongs_to :artist
end
