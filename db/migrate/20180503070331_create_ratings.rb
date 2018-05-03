class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :point
      t.references :user, foreign_key: true
      t.references :ratable, polymorphic: true

      t.timestamps
    end
  end
end
