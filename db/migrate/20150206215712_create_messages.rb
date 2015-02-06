class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :sender
      t.string :receiver
      t.text :message
      t.text :subject
      t.boolean :is_read
      t.boolean :is_friend
      
      t.timestamps
    end
  end
end
