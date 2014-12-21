class CreateInvitationPreferences < ActiveRecord::Migration
  def change
    create_table :invitation_preferences do |t|
      t.belongs_to :game_invitation

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
      t.boolean :is_mind
      t.boolean :is_bdsm
      t.boolean :is_pregnant
      t.boolean :is_inanimate
      t.boolean :is_growth
      t.boolean :is_shrink
      t.boolean :is_weight_gain
      t.boolean :is_fantasy
      t.boolean :is_bimbo
      t.boolean :is_robot
      t.boolean :is_monster_girl
      t.boolean :is_bizarre
      t.timestamps
    end
  end
end
