class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorite_lists, dependent: :destroy
  has_many :lysics, dependent: :destroy
  has_many :rates, dependent: :destroy
end
