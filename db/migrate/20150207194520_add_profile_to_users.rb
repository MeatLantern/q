class AddProfileToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :profile, :text
  	users = User.all
  	users.each do |user|
  		user.profile = "No Profile"
  		user.save
  	end
  end
end
