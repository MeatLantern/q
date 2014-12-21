class ChangeNameOfTag < ActiveRecord::Migration
  def change
  	rename_column :transformations, :is_shemale, :is_mind
  end
end
