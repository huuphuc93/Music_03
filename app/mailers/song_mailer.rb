class SongMailer < ApplicationMailer

  def new_song song
    @song = song
    mail(to: User.pluck(:email), subject: "New Song")
  end
end
