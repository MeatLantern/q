class ChangeTfMessageToText < ActiveRecord::Migration
  def change
  	change_column :games, :tf_message, :text
  end
end
