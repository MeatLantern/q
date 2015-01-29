class AddResolvedAndFeedbackToReport < ActiveRecord::Migration
  def change
  	add_column :reports, :feedback, :text
  	add_column :reports, :resolved, :boolean
  end
end
