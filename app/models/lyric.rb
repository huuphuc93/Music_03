class Lyric < ApplicationRecord
  validates :content, presence: true,
    length: {minimum: Settings.lyric.minimum_content}
  belongs_to :user
  belongs_to :song
  delegate :name, to: :user, prefix: :user, allow_nil: true
  scope :is_accepted, -> {
    where accepted: true
  }
  scope :order_name , ->{order created_at: :desc}
  scope :search_by_name, -> search do
    eager_load(:song, :user).where("songs.name LIKE ? OR users.name LIKE ?", "%#{search}%","%#{search}%")
  end
end
