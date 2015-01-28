class AddCompleteFullPicturesMultiReady < ActiveRecord::Migration
  def change
  	add_column :transformations, :completed, :boolean
  	add_column :transformations, :full_pictures, :boolean
  	add_column :users, :multi_ready, :string
  end
end
