class AddIndexesAndStuffToInvitiations < ActiveRecord::Migration
  def change
  	add_index :characters, :name
  	add_index :users, :username
  	add_index :transformations, :character_name
  	add_index :messages, :sender
  	add_index :messages, :receiver
  	add_index :games, :game_name

  	add_column :game_invitations, :rp_pref, :string
  	add_column :game_invitations, :fave_tf, :text
  	users = GameInvitation.all
  	users.each do |user|
  		user.rp_pref = "Neutral"
  		user.fave_tf = "None"
  		user.save
  	end
  end
end
