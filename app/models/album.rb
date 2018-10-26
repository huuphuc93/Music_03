class Album < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.album.maximum_name}
  has_many :songs, dependent: :destroy
  has_many :ratings, as: :ratable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :category
  belongs_to :artist
  delegate :name, to: :artist, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true
  has_attached_file :cover_image
  validates_attachment :cover_image,
    content_type: {content_type: /\Aimage\/.*\z/}
  
  scope :order_album, ->{order created_at: :desc}
  scope :search_by_name, -> search do
    where("name LIKE ? OR id LIKE ? ", "%#{search}%", "%#{search}%")
      .includes(:artist, :category)
  end
  scope :hot_albums, -> {
    select(:id, :name, :cover_image_file_name, :category_id, :artist_id).includes(:category,:artist)
      .order(view: :desc)
  }
  scope :select_albums, -> {
    select(:id, :name, :cover_image_file_name, :category_id, :artist_id).
      order(name: :asc).includes(:category, :artist)
  }
  
  scope :recommend, ->(album_id) {
    where.not(id: album_id).order(view: :desc).limit(Settings.paginate.page).
      includes :artist
  }
  def count_views
    self.view += Settings.view.count_views
    self.save
  end
end
