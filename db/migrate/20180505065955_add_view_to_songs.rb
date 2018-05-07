class AddViewToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :view, :integer, default: 0
  end
end
