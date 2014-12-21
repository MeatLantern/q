class CreateGameInvitations < ActiveRecord::Migration
  def change
    create_table :game_invitations do |t|
      t.string :player1_username
      t.string :player2_username
      t.string :player1_character
      t.string :player2_character
      t.binary :ready


      t.timestamps
    end
  end
end
