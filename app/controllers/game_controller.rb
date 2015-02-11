class GameController < ApplicationController
  include ActionView::Helpers::TextHelper
  skip_before_filter :authenticate_user! , :only => :rules
  skip_before_filter :authenticate_user! , :only => :authorize_18
  skip_before_filter :authenticate_user! , :only => :check_18
  skip_before_filter :check_18!, :only => :check_18
  skip_before_filter :check_18!, :only => :authorize_18
  skip_before_filter :check_if_in_game, :only => :check_18
  skip_before_filter :check_if_in_game, :only => :rules
  skip_before_filter :check_if_in_game, :only => :authorize_18
  skip_before_filter :set_unread_messages, :only => :check_18
  skip_before_filter :set_unread_messages, :only => :rules
  skip_before_filter :set_unread_messages, :only => :authorize_18
  #def new
  #end

  #def create
  	#All temporary implementation
  #	create_hash = {:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 10, :p1_guard => false, :p2_guard => false}
  #	Game.create!(create_hash)
  	#binding.pry
  #	redirect_to game_path
  #end

  def check_18
    #binding.pry
  end

  def about

  end

  def authorize_18
    #binding.pry
    session[:is_18] = 10
    redirect_to game_rules_path
  end

  def show

    test_game = Game.find_by_game_name(session[:current_game])

    x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]
    @player_username = z["username"]

    #test_game = Game.find_by_game_name("ad;lkfjad;lkfadf")
    #binding.pry

    if(test_game.nil?)
      redirect_to game_game_not_found_path
    else

      if (test_game.current_turn % 2) == 1
        @p1_turn = true
      else
        @p1_turn = false
      end

      if current_user.friends_list.nil?
        current_user.friends_list = ""
        current_user.save
      end
      #test_game = Game.find(1)
      @player1 = test_game.player1
      @player2 = test_game.player2
      @p1_character = Character.find_by_name(test_game.player1_character)
      @p2_character = Character.find_by_name(test_game.player2_character)
      if test_game.player1_stage < @p1_character.transformation.alt_stage
        @p1_name = @p1_character.name
        @p1_action1 = @p1_character.action_1_name
        @p1_action2 = @p1_character.action_2_name
        @p1_action3 = @p1_character.action_3_name
        @p1_action4 = @p1_character.action_4_name
        @p1_summon = @p1_character.summon_name
        @p1_summon_picture = @p1_character.summon_picture
      else
        @p1_name = @p1_character.transformation.alt_name
        @p1_action1 = @p1_character.transformation.alt_attack1_name
        @p1_action2 = @p1_character.transformation.alt_attack2_name
        @p1_action3 = @p1_character.transformation.alt_attack3_name
        @p1_action4 = @p1_character.transformation.alt_attack4_name
        @p1_summon = @p1_character.transformation.alt_summon_name
        @p1_summon_picture = @p1_character.transformation.alt_summon_picture
      end
      if test_game.player2_stage < @p2_character.transformation.alt_stage
        @p2_name = @p2_character.name
        @p2_action1 = @p2_character.action_1_name
        @p2_action2 = @p2_character.action_2_name
        @p2_action3 = @p2_character.action_3_name
        @p2_action4 = @p2_character.action_4_name
        @p2_summon = @p2_character.summon_name
        @p2_summon_picture = @p2_character.summon_picture
      else
        @p2_name = @p2_character.transformation.alt_name
        @p2_action1 = @p2_character.transformation.alt_attack1_name
        @p2_action2 = @p2_character.transformation.alt_attack2_name
        @p2_action3 = @p2_character.transformation.alt_attack3_name
        @p2_action4 = @p2_character.transformation.alt_attack4_name
        @p2_summon = @p2_character.transformation.alt_summon_name
        @p2_summon_picture = @p2_character.transformation.alt_summon_picture
      end
      @p1_hp = test_game.p1_hp
      max_hp = @p1_character.max_hp
      @p1_hp_percent = @p1_hp.fdiv(max_hp) * 100
      @p1_hp_percent = @p1_hp_percent.round

      @p1_mp = test_game.p1_mp
      max_mp = @p1_character.max_mp
      @p1_mp_percent = @p1_mp.fdiv(max_mp) * 100
      @p1_mp_percent = @p1_mp_percent.round
      #binding.pry
     
      @p2_hp = test_game.p2_hp
      max_hp = @p2_character.max_hp
      @p2_hp_percent = @p2_hp.fdiv(max_hp) * 100
      @p2_hp_percent = @p2_hp_percent.round

      @p2_mp = test_game.p2_mp
      max_mp = @p2_character.max_mp
      @p2_mp_percent = @p2_mp.fdiv(max_mp) * 100
      @p2_mp_percent = @p2_mp_percent.round

      @game_over = test_game.game_over
      @this_game = test_game
      @turn = test_game.current_turn
      @current_game = test_game
      @p1_mp_cost1 = Game::get_MP_cost(@p1_character.action_1_id)
      @p1_mp_cost2 = Game::get_MP_cost(@p1_character.action_2_id)
      @p1_mp_cost3 = Game::get_MP_cost(@p1_character.action_3_id)
      @p1_mp_cost4 = Game::get_MP_cost(@p1_character.action_4_id)
      @p2_mp_cost1 = Game::get_MP_cost(@p2_character.action_1_id)
      @p2_mp_cost2 = Game::get_MP_cost(@p2_character.action_2_id)
      @p2_mp_cost3 = Game::get_MP_cost(@p2_character.action_3_id)
      @p2_mp_cost4 = Game::get_MP_cost(@p2_character.action_4_id)

      #Format Descriptions etc
      #@player1_description = word_wrap(test_game.player1_description)

      
    end

  end

  def take_turn
  	#binding.pry
  	test_game = Game.find_by_game_name(session[:current_game])

    if(test_game.nil?)
      redirect_to game_game_not_found_path
    else
    	action_id = params["Action"]
      if(params["Action"].nil?)
        action_id = "1"
      end
      if (test_game.current_turn % 2) == 1
        character_name = test_game.player1_character
      else
        character_name = test_game.player2_character
      end

      character = Character.find_by_name(character_name)

      if test_game.player1_stage < character.transformation.alt_stage
        alt = false
      else
        alt = true
      end


      flavor = Game::get_ability_info(action_id, character_name, alt)
      action_results = Game::take_action(action_id, test_game)
      if test_game.player1_stage > character.transformation.alt_stage
        character_name = character.transformation.alt_name
      end
      #binding.pry
    	 flavor_string = "#{character_name} uses #{flavor["ability_name"]}! #{flavor["ability_flavor"]}"
       results_string = "#{action_results}"
      #flash[:results] = results_string
      test_game.flavor_message = flavor_string
      test_game.results_message = results_string
      #Transformation Stuff
      test_game.tf_message = Transformation::transformation_handler(test_game)
    	test_game.save
    	redirect_to game_show_path
    end
  end

  def ai_take_turn
 	  test_game = Game.find_by_game_name(session[:current_game])

    #if(test_game.nil?)
    #  test_game = Game.find(1)
    #end
    ai_character = Character.find_by_name(test_game.player2_character)
    action_array = ["1","2", ai_character.action_1_id, ai_character.action_2_id, ai_character.action_3_id, ai_character.action_4_id]
 	  if (test_game.player2_debuff == "Silence")
      action_array = ["1", "2"]
    end
    if ((test_game.player2_debuff == "Mana Lock") && test_game.p2_mp < 20)
      action_array = ["1"]
    end
   action_temp = action_array.sample
   action = "#{action_temp}"
  if (action == "23")
    if (test_game.p2_hp > (ai_character.max_hp - 10))
      action_temp = action_array.sample
      action = "#{action_temp}"
    end
  end
  if(test_game.p2_mp < 20 && test_game.player2_debuff != "Mana Lock")
    action = "3"
  end
  buff_array = ["8","9","10","11","12","21","22"]
  if !(test_game.player2_buff == "None")
    buff_array.each do |buff|
      if action == buff
        action = "1"
      end
    end
  end

   character = Character.find_by_name(test_game.player2_character)
   character_name = test_game.player2_character

    if test_game.player2_stage < character.transformation.alt_stage
      alt = false
    else
      alt = true
      character_name = character.transformation.alt_name
    end


   flavor = Game::get_ability_info(action, test_game.player2_character, alt)
   action_results = Game::take_action(action, test_game)
  #binding.pry
   flavor_string = "#{character_name} uses #{flavor["ability_name"]}! #{flavor["ability_flavor"]}"
   results_string = "#{action_results}"
   #flash[:results] = results_string
   test_game.flavor_message = flavor_string
   test_game.results_message = results_string
   test_game.tf_message = Transformation::transformation_handler(test_game)
 	 test_game.save
 	 redirect_to game_show_path
 end

 def cpu_reset_game

  #binding.pry

  current_game = Game.find_by_game_name(session[:current_game])

  if(current_game.nil?)
    x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]
    game_name = z["currentgame"]
    current_game = Game.find_by_game_name(game_name)
    if(current_game.nil?)
      flash[:alert] = "Your game was not found. Your opponent may have left the game. Please start a new one."
 	    redirect_to game_game_not_found_path
    else
      session[:current_game] = current_game
    end
  else
   	character1 = Character.find_by_name(current_game.player1_character)
   	character2 = Character.find_by_name(current_game.player2_character)
   	current_game.p1_hp = character1.max_hp
   	current_game.p2_hp = character2.max_hp
   	current_game.p1_mp = character1.max_mp
   	current_game.p2_mp = character2.max_mp
   	current_game.current_turn = 1
   	current_game.game_over = false
    #Remove Any Status Effects
    current_game.player1_buff = "None"
    current_game.player1_buff_start = -50
    current_game.player1_debuff = "None"
    current_game.player1_debuff_start = -50
    current_game.player2_buff = "None"
    current_game.player2_buff_start = -50
    current_game.player2_debuff = "None"
    current_game.player2_debuff_start = -50

    #Change to Previous Flavor and Previous Turn
    current_game.flavor_message = " "
    current_game.results_message = " "
    #Change Player 1 and Player 2 Messages
    current_game.player1_message = " "
    current_game.player2_message = " "

    current_game.player1_last_tf = " "
    current_game.player2_last_tf = " "
    current_game.player1_description = character1.description
    current_game.player2_description = character2.description
    current_game.player1_stage = 0
    current_game.player2_stage = 0
    current_game.player1_picture = character1.main_image
    current_game.player2_picture = character2.main_image
    current_game.tf_message = " "
    #REMOVE THIS SOON
    #current_game.player1_debuff = "Poison"
    #current_game.player1_debuff_start = 1
   	current_game.save
   	redirect_to game_show_path
    end 
  end


  def create_ai_game

    #binding.pry

    x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]

    #binding.pry

    username = z["username"]    


    character_choice = params[:name]
    
    #Get character
    player_character = Character.find_by_name(character_choice)
    #opponent_character = Character.offset(rand(Character.count)).first
    search_hash = {}
    if(params[:rules].nil?)
      
    else
      preferences = params[:rules]
      search_hash = {}
      preferences.each do |key, value|
        if value == "false"
            search_hash[key] = false
        end
      end
   end

   search_hash["is_completed"] = true

    #if params[:rules].nil?
    #  valid_characters = Transformation.all
    #else
      valid_characters = Transformation.where(search_hash)
    #end



    opponent_tf = valid_characters.sample

    #binding.pry

    opponent_character = Character.find_by_name(opponent_tf.character_name)
    #binding.pry

    game_name = SecureRandom.base64()

    if !(z.currentgame.nil?)
      delete = Game.find_by_game_name(z.currentgame)
      Game.delete(delete)
    end

    z.currentgame = game_name

    z.save

    create_hash = {:game_name => game_name, :player1 => username, :player2 => "AI", :player1_character => character_choice, :player2_character => opponent_character.name, :player1_message => "", :player2_message => "", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 0, :player1_debuff => "None", :player1_debuff_start => 0, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => player_character.max_hp, :p2_hp => opponent_character.max_hp, :p1_mp => player_character.max_mp, :p2_mp => opponent_character.max_mp, :p1_guard => false, :p2_guard => false, :game_over => false, :player1_description => player_character.description, :player2_description => opponent_character.description, :player1_last_tf => "None",  :player2_last_tf => "None", :player1_stage => 0, :player2_stage => 0, :player1_picture => player_character.main_image, :player2_picture => opponent_character.main_image, :flavor_message => "", :tf_message => ""}
    Game.create!(create_hash)

    session[:current_game] = game_name
 
    redirect_to game_show_path
  end

  def create_choose_ai_game
     #binding.pry

    x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]

    #binding.pry

    username = z["username"]    


    character_choice = params[:player1name]
    
    #Get character
    player_character = Character.find_by_name(character_choice)
    #opponent_character = Character.offset(rand(Character.count)).first
    

    opponent_character = Character.find_by_name(params[:player2name])

    #binding.pry

    #opponent_character = Character.find_by_name(opponent_tf.character_name)
    #binding.pry

    game_name = SecureRandom.base64()

    if !(z.currentgame.nil?)
      delete = Game.find_by_game_name(z.currentgame)
      Game.delete(delete)
    end

    z.currentgame = game_name

    z.save

    create_hash = {:game_name => game_name, :player1 => username, :player2 => "AI", :player1_character => character_choice, :player2_character => opponent_character.name, :player1_message => "", :player2_message => "", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 0, :player1_debuff => "None", :player1_debuff_start => 0, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => player_character.max_hp, :p2_hp => opponent_character.max_hp, :p1_mp => player_character.max_mp, :p2_mp => opponent_character.max_mp, :p1_guard => false, :p2_guard => false, :game_over => false, :player1_description => player_character.description, :player2_description => opponent_character.description, :player1_last_tf => "None",  :player2_last_tf => "None", :player1_stage => 0, :player2_stage => 0, :player1_picture => player_character.main_image, :player2_picture => opponent_character.main_image, :flavor_message => "", :tf_message => ""}
    Game.create!(create_hash)

    session[:current_game] = game_name
 
    redirect_to game_show_path
  end

  def game_not_found
    flash[:alert] = "Your game was not found. Your opponent may have left the game. Please start a new one."
    redirect_to game_rules_path
  end

  def leave_game
  
  end

  def destroy_current_game
    #if(params["Action"] == "1" )
      current_game = Game.find_by_game_name(session[:current_game])

      if(current_game.nil?)
        redirect_to game_game_not_found_path
      else
        if current_game.player2 != "AI"
          p2 = current_game.player2
        end
        Game.delete(current_game)
        session[:current_game] = nil
        x = session["warden.user.user.key"]
        y = User.find(x[0])
        z = y[0]
        z.currentgame = nil
        z.save
        if(current_game.player2 != "AI")
          player2 = User.find_by_username(p2)
          player2.currentgame = nil
          player2.save
        end
        #binding.pry
        redirect_to game_rules_path
      end
    #else
    # redirect_to game_show_path
    #end
  end

 def rules
    if !(current_user.nil?)
      game_name = current_user.currentgame
        #binding.pry
        if !(game_name.nil?)
          current_game = Game.find_by_game_name(game_name)
          if(current_game.nil?)
            #redirect_to game_game_not_found_path
            flash[:alert] = "Your Game Has Ended. Your Opponent may have Left the Game."
            current_user.currentgame = nil
            current_user.save
            session[:current_game] = nil
          else
            session[:current_game] = current_game.game_name
          end
        else
            session[:current_game] = nil 
        end
    search_hash = {}
    search_hash[:is_read] = false
    search_hash[:receiver] = current_user.username 
    unread_messages = Message.where(search_hash)
    session[:unread] = "View Messages (#{unread_messages.count})"
    end
 end

 def abilities
    #binding.pry
 end

 def send_message
    test_game = Game.find_by_game_name(session[:current_game])

    x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]
    player_username = z["username"]

    #binding.pry

    if(test_game.nil?)
      flash[:alert] = "Your game could not be found. You or your opponent may have quit the game."
      redirect_to game_rules_path
    else
      if player_username == test_game.player1
        new_message = test_game.player1_message + "[b]" + params["message"]["Your Message"] + "[/b][br]"
        test_game.player1_message = new_message
        test_game.save
        redirect_to game_show_path
      elsif player_username == test_game.player2
        new_message = test_game.player1_message + "[i]" + params["message"]["Your Message"] + "[/i][br]"
        test_game.player1_message = new_message
        test_game.save
        redirect_to game_show_path
      end
    end
 end

 def clear_message
   test_game = Game.find_by_game_name(session[:current_game])
   test_game.player1_message = " "
   test_game.save
   redirect_to game_show_path
 end

 def admin
    if current_user.is_admin
      @games = Game.all
      render :template => "/game/admin"
    else
      redirect_to game_rules_path
    end
 end

 def delete_game
    game = Game.find(params[:id])
    player1 = User.find_by_username(game.player1)
    player2 = User.find_by_username(game.player2)
    if !(player1.nil?)
      player1.currentgame = nil
      player1.save
    end
    if !(player2.nil?)
      player2.currentgame = nil
      player2.save
    end
    game.destroy
    flash[:notice] = "Game deleted"
    redirect_to game_admin_path
 end

 def delete_all
    Game.all.each do |game|
      game.destroy
    end
    flash[:notice] = "All Games Deleted"
    redirect_to game_admin_path
 end
end
