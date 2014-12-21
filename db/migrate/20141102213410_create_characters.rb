class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.text :description
      t.integer :max_hp
      t.integer :max_mp
      t.integer :base_attack
      t.integer :base_power
      t.integer :base_defense
      t.integer :base_armor
      t.string :actions
      t.string :main_image

      t.integer :action_1_id
      t.string :action_1_name
      t.string :action_1_flavor
      t.string :action_1_rules

      t.integer :action_2_id
      t.string :action_2_name
      t.string :action_2_flavor
      t.string :action_2_rules

      t.integer :action_3_id
      t.string :action_3_name
      t.string :action_3_flavor
      t.string :action_3_rules

      t.integer :action_4_id
      t.string :action_4_name
      t.string :action_4_flavor
      t.string :action_4_rules

      t.string :summon_name
      t.string :summon_picture
      t.string :summon_attack

      t.string :creator

      t.timestamps
    end
  end
end
