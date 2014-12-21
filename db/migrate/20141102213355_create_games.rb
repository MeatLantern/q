class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :game_name
      t.string :player1
      t.string :player2
      t.string :player1_character
      t.string :player2_character
      t.text :player1_message
      t.text :player2_message
      t.integer :current_turn
      t.string :player1_buff
      t.integer :player1_buff_start
      t.string :player2_buff
      t.integer :player2_buff_start
      t.string :player1_debuff
      t.integer :player1_debuff_start
      t.string :player2_debuff
      t.integer :player2_debuff_start
      t.integer :p1_hp
      t.integer :p2_hp
      t.integer :p1_mp
      t.integer :p2_mp
      t.binary :p1_guard
      t.binary :p2_guard
      t.binary :game_over
      t.text :flavor_message
      t.text :results_message

      t.timestamps
    end
  end
end
