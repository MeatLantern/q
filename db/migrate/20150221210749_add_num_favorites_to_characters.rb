class AddNumFavoritesToCharacters < ActiveRecord::Migration
  def change
  	add_column :characters, :num_favorites, :integer, :default => 0

  end
end
