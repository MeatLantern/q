# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141219214621) do

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "max_hp"
    t.integer  "max_mp"
    t.integer  "base_attack"
    t.integer  "base_power"
    t.integer  "base_defense"
    t.integer  "base_armor"
    t.string   "actions"
    t.string   "main_image"
    t.integer  "action_1_id"
    t.string   "action_1_name"
    t.string   "action_1_flavor"
    t.string   "action_1_rules"
    t.integer  "action_2_id"
    t.string   "action_2_name"
    t.string   "action_2_flavor"
    t.string   "action_2_rules"
    t.integer  "action_3_id"
    t.string   "action_3_name"
    t.string   "action_3_flavor"
    t.string   "action_3_rules"
    t.integer  "action_4_id"
    t.string   "action_4_name"
    t.string   "action_4_flavor"
    t.string   "action_4_rules"
    t.string   "summon_name"
    t.string   "summon_picture"
    t.string   "summon_attack"
    t.string   "creator"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "game_invitations", :force => true do |t|
    t.string   "player1_username"
    t.string   "player2_username"
    t.string   "player1_character"
    t.string   "player2_character"
    t.binary   "ready"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "game_name"
    t.string   "player1"
    t.string   "player2"
    t.string   "player1_character"
    t.string   "player2_character"
    t.text     "player1_message"
    t.text     "player2_message"
    t.integer  "current_turn"
    t.string   "player1_buff"
    t.integer  "player1_buff_start"
    t.string   "player2_buff"
    t.integer  "player2_buff_start"
    t.string   "player1_debuff"
    t.integer  "player1_debuff_start"
    t.string   "player2_debuff"
    t.integer  "player2_debuff_start"
    t.integer  "p1_hp"
    t.integer  "p2_hp"
    t.integer  "p1_mp"
    t.integer  "p2_mp"
    t.binary   "p1_guard"
    t.binary   "p2_guard"
    t.binary   "game_over"
    t.text     "flavor_message"
    t.text     "results_message"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.text     "player1_last_tf"
    t.text     "player2_last_tf"
    t.text     "player1_description"
    t.text     "player2_description"
    t.integer  "player1_stage"
    t.integer  "player2_stage"
    t.string   "player1_picture"
    t.string   "player2_picture"
    t.string   "tf_message"
  end

  create_table "invitation_preferences", :force => true do |t|
    t.integer  "game_invitation_id"
    t.boolean  "is_adult"
    t.boolean  "is_M2F"
    t.boolean  "is_F2M"
    t.boolean  "is_race_change"
    t.boolean  "is_age_reg"
    t.boolean  "is_age_pro"
    t.boolean  "is_furry"
    t.boolean  "is_animal"
    t.boolean  "is_futa"
    t.boolean  "is_mind"
    t.boolean  "is_bdsm"
    t.boolean  "is_pregnant"
    t.boolean  "is_inanimate"
    t.boolean  "is_growth"
    t.boolean  "is_shrink"
    t.boolean  "is_weight_gain"
    t.boolean  "is_fantasy"
    t.boolean  "is_bimbo"
    t.boolean  "is_robot"
    t.boolean  "is_monster_girl"
    t.boolean  "is_bizarre"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "transformations", :force => true do |t|
    t.integer  "character_id"
    t.string   "character_name"
    t.string   "stage1_tf_picture"
    t.text     "stage1_tf_description"
    t.text     "stage1_character_description"
    t.string   "stage2_tf_picture"
    t.text     "stage2_tf_description"
    t.text     "stage2_character_description"
    t.string   "stage3_tf_picture"
    t.text     "stage3_tf_description"
    t.text     "stage3_character_description"
    t.string   "stage4_tf_picture"
    t.text     "stage4_tf_description"
    t.text     "stage4_character_description"
    t.string   "stage5_tf_picture"
    t.text     "stage5_tf_description"
    t.text     "stage5_character_description"
    t.string   "stage6_tf_picture"
    t.text     "stage6_tf_description"
    t.text     "stage6_character_description"
    t.string   "stage7_tf_picture"
    t.text     "stage7_tf_description"
    t.text     "stage7_character_description"
    t.string   "stage8_tf_picture"
    t.text     "stage8_tf_description"
    t.text     "stage8_character_description"
    t.string   "stage9_tf_picture"
    t.text     "stage9_tf_description"
    t.text     "stage9_character_description"
    t.string   "stage10_tf_picture"
    t.text     "stage10_tf_description"
    t.text     "stage10_character_description"
    t.boolean  "is_adult"
    t.boolean  "is_M2F"
    t.boolean  "is_F2M"
    t.boolean  "is_race_change"
    t.boolean  "is_age_reg"
    t.boolean  "is_age_pro"
    t.boolean  "is_furry"
    t.boolean  "is_animal"
    t.boolean  "is_futa"
    t.boolean  "is_mind"
    t.boolean  "is_bdsm"
    t.boolean  "is_pregnant"
    t.boolean  "is_inanimate"
    t.boolean  "is_growth"
    t.boolean  "is_shrink"
    t.boolean  "is_weight_gain"
    t.boolean  "is_fantasy"
    t.boolean  "is_bimbo"
    t.boolean  "is_bizarre"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "is_robot"
    t.boolean  "is_monster_girl"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "currentgame"
    t.boolean  "is_admin",               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
