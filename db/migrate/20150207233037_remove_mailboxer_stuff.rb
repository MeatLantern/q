class RemoveMailboxerStuff < ActiveRecord::Migration
  def change
  	drop_table :mailboxer_conversation_opt_outs
  	drop_table :mailboxer_conversations
  	drop_table :mailboxer_notifications
  	drop_table :mailboxer_receipts
  end
end
