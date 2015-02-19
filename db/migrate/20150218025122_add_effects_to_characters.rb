class AddEffectsToCharacters < ActiveRecord::Migration
  def change
  	add_column :characters, :basic_effect, :string
  	add_column :characters, :effect1, :string
  	add_column :characters, :effect2, :string
  	add_column :characters, :effect3, :string
  	add_column :characters, :effect4, :string
  end
end
