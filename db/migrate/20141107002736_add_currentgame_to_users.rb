class AddCurrentgameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :currentgame, :string
  end
end
