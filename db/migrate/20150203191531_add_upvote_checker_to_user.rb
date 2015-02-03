class AddUpvoteCheckerToUser < ActiveRecord::Migration
  def change
  	 add_column :users, :upvote_checker, :text
  end
end
