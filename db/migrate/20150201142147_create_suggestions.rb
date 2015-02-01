class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :username
      t.text :suggestion
      t.timestamps
    end
  end
end
