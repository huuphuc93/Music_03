class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :song, foreign_key: true
      t.references :favorite_list, foreign_key: true

      t.timestamps
    end
    add_index :favorites, [:song_id, :favorite_list_id], unique: true
  end
end
