class Favorite < ApplicationRecord
  belongs_to :song
  belongs_to :favorite_list
end
