class CreateLyrics < ActiveRecord::Migration[5.1]
  def change
    create_table :lyrics do |t|
      t.text :content
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
