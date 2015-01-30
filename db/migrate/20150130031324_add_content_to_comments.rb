class AddContentToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :username, :string
  	add_column :comments, :character, :string
  	add_column :comments, :owner, :string
  	add_column :comments, :comment, :text
  	add_column :comments, :flag, :boolean
  end
end
