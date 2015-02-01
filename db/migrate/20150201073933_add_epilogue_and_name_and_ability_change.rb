class AddEpilogueAndNameAndAbilityChange < ActiveRecord::Migration
  def change
  	add_column :transformations, :epilogue, :text

  	add_column :transformations, :alt_name, :string

  	add_column :transformations, :alt_attack1_name, :string
  	add_column :transformations, :alt_attack2_name, :string
  	add_column :transformations, :alt_attack3_name, :string
  	add_column :transformations, :alt_attack4_name, :string

  	add_column :transformations, :alt_attack1_description, :text
  	add_column :transformations, :alt_attack2_description, :text
  	add_column :transformations, :alt_attack3_description, :text
  	add_column :transformations, :alt_attack4_description, :text

  	add_column :transformations, :alt_stage, :integer

  	tfs = Transformation.all
  	tfs.each do |tf|
  		tf.epilogue = "No Epilogue"
  		tf.alt_name = tf.character_name
  		character = Character.find_by_name(tf.character_name)
  		tf.alt_attack1_name = character.action_1_name
  		tf.alt_attack1_description = character.action_1_flavor
  		tf.alt_attack2_name = character.action_2_name
  		tf.alt_attack2_description = character.action_2_flavor
  		tf.alt_attack3_name = character.action_3_name
  		tf.alt_attack3_description = character.action_3_flavor
  		tf.alt_attack4_name = character.action_4_name
  		tf.alt_attack4_description = character.action_4_flavor
  		tf.alt_stage = 5
  		tf.save
  	end

  end
end
