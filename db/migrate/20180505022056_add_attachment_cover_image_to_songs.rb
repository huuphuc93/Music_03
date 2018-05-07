class AddAttachmentCoverImageToSongs < ActiveRecord::Migration[5.1]
  def self.up
    change_table :songs do |t|
      t.attachment :cover_image
    end
  end

  def self.down
    remove_attachment :songs, :cover_image
  end
end
