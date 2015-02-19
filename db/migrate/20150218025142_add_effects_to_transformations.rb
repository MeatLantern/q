class AddEffectsToTransformations < ActiveRecord::Migration
  def change
  	add_column :transformations, :alt_basic_effect, :string
  	add_column :transformations, :alt_effect1, :string
  	add_column :transformations, :alt_effect2, :string
  	add_column :transformations, :alt_effect3, :string
  	add_column :transformations, :alt_effect4, :string
  end
end
