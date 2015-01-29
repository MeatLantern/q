class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :character_name
      t.string :character_creator
      t.string :reporter
      t.text :report

      t.timestamps
    end
  end
end
