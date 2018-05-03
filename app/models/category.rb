class Category < ApplicationRecord
  has_many :albums, dependent: :destroy
end
