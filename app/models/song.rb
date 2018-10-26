class Song < ApplicationRecord
  validates :name, presence: true,
    length: {minimum: Settings.lyric.minimum_content}
  has_many :lyrics, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_lists, through: :favorites
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :ratings, as: :ratable, dependent: :destroy
  belongs_to :album
  delegate :name, to: :album, prefix: :album, allow_nil: true
  delegate :name, to: "album.category", prefix: :category, allow_nil: true
  delegate :name, to: "album.artist", prefix: :artist, allow_nil: true
  has_attached_file :audio
  has_attached_file :cover_image
  validates_attachment :audio,
    content_type: {content_type: ["audio/mpeg", "audio/mp3"]},
    file_name: {matches: [/mp3\Z/]}
  validates_attachment :cover_image,
    content_type: {content_type: /\Aimage\/.*\z/}

  scope :order_song , ->{order created_at: :desc}
  scope :search_by_name, -> search do
    eager_load(:album).where("songs.name LIKE ? OR albums.name 
      LIKE ?", "%#{search}%", "%#{search}%")
  end
  scope :recommend, -> song_id {
    where.not(id: song_id).order(view: :desc).limit(Settings.paginate.page).
      includes album: [:artist]
  }
  scope :hot_song, -> {
    where(hot_song: true).order(view: :desc)
  }
  
  scope :search_song, -> content {
    select(:id, :name, :album_id).eager_load(album: [:category, :artist])
      .where("songs.name LIKE ? OR albums.name LIKE ? OR artists.name LIKE ? 
      OR categories.name LIKE ?", "%#{content}%", "%#{content}%",
      "%#{content}%", "%#{content}%")
  }

  def count_views
    self.view += Settings.view.count_views
    self.save
  end
end
