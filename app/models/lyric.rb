class Lyric < ApplicationRecord
  belongs_to :user
  belongs_to :song
  delegate :name, to: :user, prefix: :user, allow_nil: true
  scope :is_accepted, -> {
    where(accepted: true)
  }
end
