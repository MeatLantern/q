class AddUpvotes < ActiveRecord::Migration
  def change
  	add_column :characters, :upvotes, :integer
  end
end
