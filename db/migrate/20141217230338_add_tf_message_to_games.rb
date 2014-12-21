class AddTfMessageToGames < ActiveRecord::Migration
  def change
  	add_column :games, :tf_message, :string
  end
end
