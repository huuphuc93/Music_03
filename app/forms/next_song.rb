class NextSong
  def initialize song_id, album_id = nil, favorite_list_id = nil
    @song_id = song_id
    @album_id = album_id
    @favorite_list_id = favorite_list_id
  end
  
  def next_song
    get_song_collection
    @song = Song.find_by id: @song_id
    return @song unless @songs
    index = @songs.index @song
    @song = @songs[index + 1]
  end
  
  def get_song_collection
    if @album_id
      @list = Album.find_by id: @album_id    
    end
    
    if @favorite_list_id
      @list = FavoriteList.find_by id: @favorite_list_id
    end
    
    return unless @list
    @songs = @list.songs
  end
end