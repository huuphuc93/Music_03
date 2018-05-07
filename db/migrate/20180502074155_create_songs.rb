class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.attachment :audio
      
      t.timestamps
    end
  end
end
