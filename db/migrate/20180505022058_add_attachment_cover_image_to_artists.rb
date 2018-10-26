class AddAttachmentCoverImageToArtists < ActiveRecord::Migration[5.1]
  def self.up
    change_table :artists do |t|
      t.attachment :cover_image
    end
  end

  def self.down
    remove_attachment :artists, :cover_image
  end
end
