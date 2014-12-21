class AddStagesToGames < ActiveRecord::Migration
  def change
  	add_column :games, :player1_stage, :integer
  	add_column :games, :player2_stage, :integer
  end
end
