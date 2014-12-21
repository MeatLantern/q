class AddTransformationsToGame < ActiveRecord::Migration
  def change
  	add_column :games, :player1_last_tf, :text
  	add_column :games, :player2_last_tf, :text
  	add_column :games, :player1_description, :text
  	add_column :games, :player2_description, :text

  end
end
