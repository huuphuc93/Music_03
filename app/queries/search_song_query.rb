class SearchSongQuery
  def initialize content, songs = Song.all
    @content = content
    @songs = songs
  end
  
  def search_songs
    @songs.find search_song_ids
  end
  
  def search_song_ids
    @song_ids = @songs.find_by_sql(query).pluck(:id)
  end
  
  private
  
  def query
    <<-SQL
      SELECT DISTINCT songs.id FROM songs
      LEFT JOIN albums ON songs.album_id = albums.id
      LEFT JOIN artists ON albums.artist_id = artists.id
      LEFT JOIN categories ON albums.category_id = categories.id
      WHERE songs.name LIKE '%#{@content}%' OR albums.name LIKE '%#{@content}%'
      OR artists.name LIKE '%#{@content}%'
      OR categories.name LIKE '%#{@content}%'
    SQL
  end
end