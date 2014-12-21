class InvitationPreferencesController < ApplicationController

  def change
  	change_hash = params["transformation"]
  	invite_id = params["invite_id"]
  	invite = GameInvitation.find_by_id(invite_id)
  	pref = invite.invitation_preferences
  	if pref.nil?
  		p = InvitationPreferences.create!(change_hash)
  		invite.invitation_preferences = p
  		p.save
  		redirect_to game_invitation_show_path(:invite => invite)
  	else
  		pref.update_attributes(change_hash)
  		pref.save
  		redirect_to game_invitation_show_path(:invite => invite)
  	end
  end

end
