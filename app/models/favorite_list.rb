class FavoriteList < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.favorite_list.maximum_name}
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :ratings, as: :ratable, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :songs, through: :favorites
  belongs_to :user
  
  scope :recommend, ->(favorite_list_id) {
    where.not(id: favorite_list_id).order(view: :desc).includes(:user).
      limit Settings.paginate.page
  }
  
  def count_views
    self.view += Settings.view.count_views
    self.save
  end
end
