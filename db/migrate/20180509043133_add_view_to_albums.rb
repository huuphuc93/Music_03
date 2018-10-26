class AddViewToAlbums < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :view, :integer, default: 0
  end
end
