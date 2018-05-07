class AddReferencesToLyrics < ActiveRecord::Migration[5.1]
  def change
    add_reference :lyrics, :song, foreign_key: true
    add_reference :lyrics, :user, foreign_key: true
  end
end
