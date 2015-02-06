class AddFriendsListToUser < ActiveRecord::Migration
  def change
  	add_column :users, :friends_list, :text
  	users = User.all
  	users.each do |user|
  		user.friends_list = ""
  		user.save
  	end
  end
end
