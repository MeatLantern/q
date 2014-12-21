class GameController < ApplicationController
  include ActionView::Helpers::TextHelper
  skip_before_filter :authenticate_user! , :only => :rules
  skip_before_filter :authenticate_user! , :only => :authorize_18
  skip_before_filter :authenticate_user! , :only => :check_18
  skip_before_filter :check_18!, :only => :check_18
  skip_before_filter :check_18!, :only => :authorize_18
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

  def authorize_18
    #binding.pry
    session[:is_18] = 10
    redirect_to game_rules_path
  end

  def show

    #create_hash = {:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 5, :game_over => false}
    #Game.create!(create_hash)
    
    test_game = Game.find_by_game_name(session[:current_game])

    x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]
    @player_username = z["username"]


    #binding.pry

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

      #test_game = Game.find(1)
      @player1 = test_game.player1
      @player2 = test_game.player2
      @p1_character = Character.find_by_name(test_game.player1_character)
      @p2_character = Character.find_by_name(test_game.player2_character)
      @p1_hp = test_game.p1_hp
      @p1_mp = test_game.p1_mp
      @p2_hp = test_game.p2_hp
      @p2_mp = test_game.p2_mp
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

      #binding.pry
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

      flavor = Game::get_ability_info(action_id, character_name)
      action_results = Game::take_action(action_id, test_game)
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
    action_array = ["1","2","3", ai_character.action_1_id, ai_character.action_2_id, ai_character.action_3_id, ai_character.action_4_id]
 	  if (test_game.player2_debuff == "Silence")
      action_array = ["1", "2", "3"]
    end
   action_temp = action_array.sample
   action = "#{action_temp}"
  if(test_game.p2_mp < 20)
    action = "3"
  end
   flavor = Game::get_ability_info(action, test_game.player2_character)
   action_results = Game::take_action(action, test_game)
  #binding.pry
   flavor_string = "#{test_game.player2_character} uses #{flavor["ability_name"]}! #{flavor["ability_flavor"]}"
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
      flash[:warning] = "Your game was not found. Your opponent may have left the game. Please start a new one."
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
    current_game.flavor_message = ""
    current_game.results_message = ""
    #Change Player 1 and Player 2 Messages
    current_game.player1_message = ""
    current_game.player2_message = ""

    current_game.player1_last_tf = ""
    current_game.player2_last_tf = ""
    current_game.player1_description = character1.description
    current_game.player2_description = character2.description
    current_game.player1_stage = 0
    current_game.player2_stage = 0
    current_game.player1_picture = character1.main_image
    current_game.player2_picture = character2.main_image
    current_game.tf_message = ""
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

    if params[:rules].nil?
      valid_characters = Transformation.all
    else
      valid_characters = Transformation.where(search_hash)
    end

    opponent_tf = valid_characters.sample

    #binding.pry

    opponent_character = Character.find_by_name(opponent_tf.character_name)
    #binding.pry

    game_name = SecureRandom.base64()

    z.currentgame = game_name

    z.save

    create_hash = {:game_name => game_name, :player1 => username, :player2 => "AI", :player1_character => character_choice, :player2_character => opponent_character.name, :player1_message => "", :player2_message => "", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 0, :player1_debuff => "None", :player1_debuff_start => 0, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => player_character.max_hp, :p2_hp => opponent_character.max_hp, :p1_mp => player_character.max_mp, :p2_mp => opponent_character.max_mp, :p1_guard => false, :p2_guard => false, :game_over => false, :player1_description => player_character.description, :player2_description => opponent_character.description, :player1_last_tf => "None",  :player2_last_tf => "None", :player1_stage => 0, :player2_stage => 0, :player1_picture => player_character.main_image, :player2_picture => opponent_character.main_image}
    Game.create!(create_hash)

    session[:current_game] = game_name
 
    redirect_to game_show_path
  end

  def game_not_found
    flash[:warning] = "Your game was not found. Your opponent may have left the game. Please start a new one."
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
        Game.delete(current_game.id)
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
    x = session["warden.user.user.key"]

    #binding.pry

    if(not x.nil?)
      y = User.find(x[0])
      z = y[0]
      game_name = z["currentgame"]
      #binding.pry
      #binding.pry
      if(not game_name.nil?)
        current_game = Game.find_by_game_name(game_name)
        if(current_game.nil?)
          #redirect_to game_game_not_found_path
          y.currentgame = nil
          y.save
          session[:current_game] = nil
        else
          session[:current_game] = current_game.game_name
        end
      else
          #binding.pry
          session[:current_game] = nil 
      end
    else
      session[:current_game] = nil
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
      flash[:warning] = "Your game could not be found. You or your opponent may have quit the game."
      redirect_to game_rules_path
    else
      if player_username == test_game.player1
        test_game.player1_message = params["message"]["Your Message"]
        test_game.save
        redirect_to game_show_path
      elsif player_username == test_game.player2
        test_game.player2_message = params["message"]["Your Message"]
        test_game.save
        redirect_to game_show_path
      end
    end
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
    flash[:success] = "Game deleted"
    redirect_to game_admin_path
 end

 def delete_all
    Game.all.each do |game|
      game.destroy
    end
    flash[:success] = "Games deleted"
    redirect_to game_admin_path
 end
end
