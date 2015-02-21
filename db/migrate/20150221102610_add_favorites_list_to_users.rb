class AddFavoritesListToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :favorites_list, :text
  	users = User.all
  	users.each do |user|
  		user.favorites_list = ""
  		user.save
  	end
  end
end
