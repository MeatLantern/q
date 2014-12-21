class GameInvitation < ActiveRecord::Base
  has_one :invitation_preferences
  attr_protected

  def GameInvitation::check_if_ready(current_invite)
  	#current_invite = GameInvitation.find_by_id(invite_id)
  	p1 = current_invite.player1_username
  	p2 = current_invite.player2_username
  	c1 = current_invite.player1_character
  	c2 = current_invite.player2_character
  	if(p1.nil? || p2.nil? || c1.nil? || c2.nil?)
  		
  	else
  		current_invite.ready = true
  		current_invite.save
  	end
  end
end
