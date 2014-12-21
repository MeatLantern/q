class CreateTransformations < ActiveRecord::Migration
  def change
    create_table :transformations do |t|
      t.belongs_to :character

      t.string :character_name
      #TF Description Details
      t.string :stage1_tf_picture
      t.text :stage1_tf_description
      t.text :stage1_character_description

      t.string :stage2_tf_picture
      t.text :stage2_tf_description
      t.text :stage2_character_description

      t.string :stage3_tf_picture
      t.text :stage3_tf_description
      t.text :stage3_character_description

      t.string :stage4_tf_picture
      t.text :stage4_tf_description
      t.text :stage4_character_description

      t.string :stage5_tf_picture
      t.text :stage5_tf_description
      t.text :stage5_character_description

      t.string :stage6_tf_picture
      t.text :stage6_tf_description
      t.text :stage6_character_description

      t.string :stage7_tf_picture
      t.text :stage7_tf_description
      t.text :stage7_character_description

      t.string :stage8_tf_picture
      t.text :stage8_tf_description
      t.text :stage8_character_description

      t.string :stage9_tf_picture
      t.text :stage9_tf_description
      t.text :stage9_character_description

      t.string :stage10_tf_picture
      t.text :stage10_tf_description
      t.text :stage10_character_description

      #Tf Tags
      t.boolean :is_adult
      t.boolean :is_M2F
      t.boolean :is_F2M
      t.boolean :is_race_change
      t.boolean :is_age_reg
      t.boolean :is_age_pro
      t.boolean :is_furry
      t.boolean :is_animal
      t.boolean :is_futa
      t.boolean :is_shemale
      t.boolean :is_bdsm
      t.boolean :is_pregnant
      t.boolean :is_inanimate
      t.boolean :is_growth
      t.boolean :is_shrink
      t.boolean :is_weight_gain
      t.boolean :is_fantasy
      t.boolean :is_bimbo
      t.boolean :is_bizarre


      t.timestamps
    end
  end
end
