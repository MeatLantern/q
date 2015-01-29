class AddReasonsToReport < ActiveRecord::Migration
  def change
  	add_column :reports, :reasons, :string
  end
end
