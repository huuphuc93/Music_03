class Category < ApplicationRecord
  has_many :albums, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.category.maximum_name}
  
  scope :order_name , ->{order(created_at: :desc)}
  scope :search_by_name, -> search do
    select(:id, :name, :created_at)
      .where("name LIKE ? OR id LIKE ? ", "%#{search}%", "%#{search}%")
  end
end
