class AddEffectsToGames < ActiveRecord::Migration
  def change
  	add_column :games, :p1_effect, :string
  	add_column :games, :p2_effect, :string
  	add_column :games, :p1_use_effects, :boolean
  	add_column :games, :p2_use_effects, :boolean
  end
end
