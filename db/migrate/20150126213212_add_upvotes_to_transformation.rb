class AddUpvotesToTransformation < ActiveRecord::Migration
  def change
  	add_column :transformations, :upvotes, :integer
  end
end
