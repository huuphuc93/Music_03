module SongHelper
  def hot_song song
    song.hot_song ? "Hot" : ""
  end
end