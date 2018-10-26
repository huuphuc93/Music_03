class Artist < ApplicationRecord
  validates :name, presence: true
  has_many :albums, dependent: :destroy
  has_many :songs, through: :albums, dependent: :destroy
  has_attached_file :cover_image
  validates_attachment :cover_image,
    content_type: {content_type: /\Aimage\/.*\z/}
  validates :name, presence: true, 
    length: {maximum: Settings.artist.maximum_name}
  
  scope :order_artist , ->{order created_at: :desc}
  scope :search_by_name, -> search do
    select(:id, :name, :created_at).where("name LIKE ? ", "%#{search}%")
  end
end
