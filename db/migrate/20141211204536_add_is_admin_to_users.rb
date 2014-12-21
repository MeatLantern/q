class AddIsAdminToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_admin, :boolean, :default => true
  end
end
