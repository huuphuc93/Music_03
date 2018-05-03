class AddReferencesToLysics < ActiveRecord::Migration[5.1]
  def change
    add_reference :lysics, :song, foreign_key: true
    add_reference :lysics, :user, foreign_key: true
  end
end
