class GameInvitationController < ApplicationController

	def invitations_screen
		x = session["warden.user.user.key"]
    	y = User.find(x[0])
    	z = y[0]
    	player1_username = z["username"]
    	#create_hash = {"player1_username" => player1_username, "player2_username" => nil, "player1_character" => nil, "player2_character" => nil, "ready" => false}
    	#GameInvitation.create!(create_hash)
		@invites = GameInvitation.all
		#binding.pry
		#render "invitations_screen"
	end

	def new
		x = session["warden.user.user.key"]
    	y = User.find(x[0])
    	z = y[0]
    	player1_username = z["username"]
    	create_hash = {"player1_username" => player1_username, "player2_username" => nil, "player1_character" => nil, "player2_character" => nil, "ready" => false}
    	game = GameInvitation.create!(create_hash)
    	create_hash = {:is_adult => true, :is_M2F => true, :is_F2M => true, :is_race_change => true, :is_age_reg => true, :is_age_pro => true, :is_furry => true, :is_animal => true, :is_futa => true, :is_mind => true, :is_bdsm => true, :is_pregnant => true, :is_inanimate => true, :is_growth => true, :is_shrink => true, :is_weight_gain => true, :is_fantasy => true, :is_bimbo => true, :is_robot => true, :is_monster_girl => true, :is_bizarre => true }
    	game.invitation_preferences = InvitationPreferences.create!(create_hash)
    	GameInvitation::destroy_old_invites
    	redirect_to game_invitation_show_path(:invite => game.id)
	end

	def show
		@invite = GameInvitation.find_by_id(params["invite"])
		if (@invite.nil?)
			flash[:alert] = "Your game invite could not be found. Your opponent may have started or deleted the game. If it has been started, please click 'Back to Game' to play."
			redirect_to game_rules_path
		else
			GameInvitation::check_if_ready(@invite)
			x = session["warden.user.user.key"]
	    	y = User.find(x[0])
	    	z = y[0]
	    	@current_username = z["username"]
	    	@pref = @invite.invitation_preferences
	    	if @pref.nil?
	    		create_hash = {:is_adult => true, :is_M2F => true, :is_F2M => true, :is_race_change => true, :is_age_reg => true, :is_age_pro => true, :is_furry => true, :is_animal => true, :is_futa => true, :is_mind => true, :is_bdsm => true, :is_pregnant => true, :is_inanimate => true, :is_growth => true, :is_shrink => true, :is_weight_gain => true, :is_fantasy => true, :is_bimbo => true, :is_robot => true, :is_monster_girl => true, :is_bizarre => true }
    			@invite.invitation_preferences = InvitationPreferences.create!(create_hash)
    			@pref = @invite.invitation_preferences
	    	end
	    	@tag_list = InvitationPreferences::get_tag_list(@pref)
	    	@tf_hash = InvitationPreferences::get_transformation_hash(@pref)
	    end
    	#binding.pry
		#binding.pry
	end

	def destroy
		#binding.pry
		x = session["warden.user.user.key"]
    	y = User.find(x[0])
    	z = y[0]
    	username = z["username"]
		invite = GameInvitation.find_by_id(params["id"])
		if(username == invite.player1_username)
			GameInvitation.destroy(invite)
			redirect_to invitations_screen_path
		else
			flash[:alert] = "You cannot delete an invite you didn't create."
			redirect_to invitations_screen_path
		end
	end

	def multiplayer_select_character
		#binding.pry
	  	if params["transformation"].nil?
	  		search_hash = {}
      		search_hash["is_completed"] = true
        	@characters = Transformation.all
      	else
	      #@characters = Transformation.all

	      preferences = params["transformation"]
	      @rules = {}

	      search_hash = {}
	      preferences.each do |key, value|
	        if value == "0"
	          search_hash[key] = false
	          @rules[key] = false
	        end
	      end
	      if (search_hash.has_key?("is_completed"))
	      	search_hash.except!("is_completed")
	      else
        	search_hash["is_completed"] = true
      	  end
      	  if (search_hash.has_key?("is_full_picture"))
        	search_hash.except!("is_full_picture")
      	  else
        	search_hash["is_full_picture"] = true
      	  end
	      @characters = Transformation.where(search_hash).order("created_at DESC")
	      #binding.pry
	      if @characters.empty?
	        flash[:notice] = "No Results Found"
	      end
	  	end
		#binding.pry
		@name = params["player_name"]
		@warning = ""
		x = session["warden.user.user.key"]
    	y = User.find(x[0])
    	z = y[0]
    	username = z["username"]
		if params["player_name"] != username
			@warning = "You are not the the player associated with this invitation. You will NOT be able to change the character."
		end

		@c = params["character"]

		@invite_id = params["invite_id"]

		invite = GameInvitation.find_by_id(@invite_id)

		@pref = invite.invitation_preferences

	end

	def multiplayer_character_choose
		#binding.pry
		invite_id = params["invite_id"]
		character_name = params["name"]
		invite_username = params["username"]
		c = params["c"]

		x = session["warden.user.user.key"]
    	y = User.find(x[0])
    	z = y[0]
    	username = z["username"]

    	if(username != invite_username)
    		flash[:alert] = "You are not the player associated with this invite. You cannot change the character."
			redirect_to invitations_screen_path

		else
			current_invite = GameInvitation.find_by_id(invite_id)
			if (c == "1")
				current_invite.player1_character = character_name
				current_invite.save
			elsif (c == "2")
				current_invite.player2_character = character_name
				current_invite.save
			end
			redirect_to game_invitation_show_path(:invite => invite_id)	
		end
	end

	def join_invite
		#binding.pry
		x = session["warden.user.user.key"]
    	y = User.find(x[0])
    	z = y[0]
    	username = z["username"]
    	invite_id = params["invite_id"]
    	current_invite = GameInvitation.find_by_id(invite_id)
    	if(current_invite.player2_username.nil?)
    		current_invite.player2_username = username
    		current_invite.save
    		if (current_invite.player1_username == current_invite.player2_username)
    			flash[:notice] = "You have chosen to play a game against yourself. Have fun?"
    		end
    		redirect_to game_invitation_show_path(:invite =>invite_id)
    	elsif (current_invite.player2_username == username)
    		flash[:alert] = "You have already joined this game invite."
    		redirect_to game_invitation_show_path(:invite =>invite_id)
    	else
    		flash[:alert] = "This game is already full. Please try and join another game."
    		redirect_to invitations_screen_path
    	end
	end

	def leave_invite
		x = session["warden.user.user.key"]
    	y = User.find(x[0])
    	z = y[0]
    	username = z["username"]
    	invite_id = params["invite_id"]
    	current_invite = GameInvitation.find_by_id(invite_id)
    	if(current_invite.player2_username.nil?)
    		flash[:alert] = "You aren't in this game yet."
    		redirect_to game_invitation_show_path(:invite =>invite_id)
    	elsif (current_invite.player2_username == username)
    		flash[:alert] = "You have successfully left the game invite."
    		current_invite.player2_username = nil
    		current_invite.player2_character = nil
    		current_invite.save
    		redirect_to invitations_screen_path
    	else
    		flash[:alert] = "This game is already full. Please try and join another game."
    		redirect_to invitations_screen_path
    	end
	end

	def multiplayer_start_game
		current_invite = GameInvitation.find_by_id(params["invite_id"])
		x = session["warden.user.user.key"]
    	y = User.find(x[0])
    	z = y[0]
    	username = z["username"]
    	if(username != current_invite.player1_username) && (username != current_invite.player2_username)
			flash[:alert] = "You can only start a game if you have joined it."
			redirect_to invitations_screen_path
		end
		#Get players
		player1 = User.find_by_username(current_invite.player1_username)
		player2 = User.find_by_username(current_invite.player2_username)

		#binding.pry

		#Check if players are currently in a game.
		if(player1["currentgame"].nil? && player2["currentgame"].nil?)
			#Create Game
		    #Get character
		    player_character = Character.find_by_name(current_invite.player1_character)
		    opponent_character = Character.find_by_name(current_invite.player2_character)

		    game_name = SecureRandom.base64()

		    player1["currentgame"] = game_name
		    player2["currentgame"] =  game_name
		    player1["multi_ready"] = nil
		    player2["multi_ready"] = nil
		    player1.save
		    player2.save

		    create_hash = {:game_name => game_name, :player1 => current_invite.player1_username, :player2 => current_invite.player2_username, :player1_character => current_invite.player1_character, :player2_character => current_invite.player2_character, :player1_message => "", :player2_message => "", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 0, :player1_debuff => "None", :player1_debuff_start => 0, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => player_character.max_hp, :p2_hp => opponent_character.max_hp, :p1_mp => player_character.max_mp, :p2_mp => opponent_character.max_mp, :p1_guard => false, :p2_guard => false, :game_over => false,:player1_description => player_character.description, :player2_description => opponent_character.description, :player1_last_tf => "None",  :player2_last_tf => "None", :player1_stage => 0, :player2_stage => 0, :player1_picture => player_character.main_image, :player2_picture => opponent_character.main_image, :tf_message => "", :flavor_message => "", :results_message => ""}
		    Game.create!(create_hash)

		    session[:current_game] = game_name
		    
			#Delete this Invitation
			current_invite.invitation_preferences.destroy
			GameInvitation.destroy(current_invite)
			#binding.pry
			redirect_to game_show_path

		else
			flash[:alert] = "One of the players is currently in a game. Both players must leave any current games before starting a new one. Please try again."
			redirect_to game_invitation_show_path(:invite =>params["invite_id"])
		end
	end

end
