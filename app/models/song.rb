class Song < ApplicationRecord
  has_many :lyrics, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_lists, through: :favorites
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :rates, as: :ratable, dependent: :destroy
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
    content_type: { content_type: /\Aimage\/.*\z/ }
  scope :recommend, ->(song_id) {
    where.not(id: "#{song_id}").order(view: :desc).limit(10)
  }

  def count_views
    self.view += 1
    self.save
  end
end
