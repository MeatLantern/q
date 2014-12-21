class AddPicturesToGames < ActiveRecord::Migration
  def change
  	add_column :games, :player1_picture, :string
  	add_column :games, :player2_picture, :string
  end
end
