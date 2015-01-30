class ChangeDescriptionsToText < ActiveRecord::Migration
  def change
  	change_column :characters, :action_1_flavor, :text
  	change_column :characters, :action_2_flavor, :text
  	change_column :characters, :action_3_flavor, :text
  	change_column :characters, :action_4_flavor, :text
  	change_column :characters, :summon_attack, :text
  end
end
