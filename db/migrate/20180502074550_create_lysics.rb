class CreateLysics < ActiveRecord::Migration[5.1]
  def change
    create_table :lysics do |t|
      t.string :content
      t.boolean :accepted

      t.timestamps
    end
  end
end
