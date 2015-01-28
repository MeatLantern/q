class RenameCompletedAndFullPictures < ActiveRecord::Migration
  def change
  	rename_column :transformations, :completed, :is_completed
  	rename_column :transformations, :full_pictures, :is_full_picture
  end
end
