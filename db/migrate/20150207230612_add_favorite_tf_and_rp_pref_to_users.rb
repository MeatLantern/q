class AddFavoriteTfAndRpPrefToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :rp_pref, :string
  	add_column :users, :fave_tf, :text
  	users = User.all
  	users.each do |user|
  		user.rp_pref = "Neutral"
  		user.fave_tf = "None"
  		user.save
  	end
  end
end
