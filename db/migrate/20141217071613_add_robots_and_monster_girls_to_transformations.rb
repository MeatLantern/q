class AddRobotsAndMonsterGirlsToTransformations < ActiveRecord::Migration
  def change
  	add_column :transformations, :is_robot, :boolean
  	add_column :transformations, :is_monster_girl, :boolean
  end
end
