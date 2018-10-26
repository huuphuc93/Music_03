class SendEmailJob < ApplicationJob
  queue_as :default

  def perform song
    SongMailer.new_song(song).deliver_now
  end
end