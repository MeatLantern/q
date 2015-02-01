class AddAltSummonOptions < ActiveRecord::Migration
  def change
  	
  	add_column :transformations, :alt_summon_name, :string
  	add_column :transformations, :alt_summon_attack, :text
  	add_column :transformations, :alt_summon_picture, :string
  	change_column :characters, :action_1_flavor, :text, :limit => nil
  	change_column :characters, :action_2_flavor, :text, :limit => nil
  	change_column :characters, :action_3_flavor, :text, :limit => nil
  	change_column :characters, :action_4_flavor, :text, :limit => nil
  	change_column :characters, :summon_attack, :text, :limit => nil


  	tfs = Transformation.all
  	tfs.each do |tf|
  		character = Character.find_by_name(tf.character_name)
  		tf.alt_summon_name = character.summon_name
  		tf.alt_summon_attack = character.summon_attack
  		tf.alt_summon_picture = character.summon_picture
  		tf.save
  	end
  end
end
