class AddHotSongToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :hot_song, :boolean
  end
end
