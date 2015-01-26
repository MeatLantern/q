class CharactersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def new
  end

  def upvote
    recent = session[:recent_upvotes]
    if recent.nil?
      recent = []
      session[:recent_upvotes] = recent
    end
    c = Character.find_by_name(params[:name])
    if c.nil?
      flash[:warning] = "The Character Could not be found."
      redirect_to game_rules_path
    else
      if recent.include?(params[:name])
        flash[:warning] = "You cannot upvote the same character more than once."
      else
        recent.push(params[:name])
        c.upvotes = c.upvotes + 1
        c.save
      end
      redirect_to characters_path(:name => params[:name])
    end
  end

  def set_upvotes_to_0
    all_characters = Character.all
    all_characters.each do |character|
      character.upvotes = 0
      if !(character.transformation.nil?)
        character.transformation.upvotes = 0
        character.transformation.save
      end
      character.save
    #binding.pry
    redirect_to game_rules_path
  end

  def create

    x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]
    player1_username = z["username"]
    @valid = true
   
    @string1 = ""
    @string2 = ""
    @string3 = ""
    @string4 = ""
    @string5 = ""
    @string6 = ""
    @string7 = ""
    @string8 = ""
    @string9 = ""
    @string10 = ""
    @string11 = ""
    @string12 = ""
    @string13 = ""
    @string14 = ""
    @string15 = ""

    #binding.pry

    @name = params[:character][:name]
    @description = params[:character][:description]
    @description = word_wrap(@description)
    @max_hp = params[:character][:max_hp].to_i
    @max_mp = params[:character][:max_mp].to_i
    @base_attack = params[:character][:base_attack].to_i
    @base_power = params[:character][:base_power].to_i
    @base_defense = params[:character][:base_defense].to_i
    @base_armor = params[:character][:base_armor].to_i

    @action_1_name = params[:character][:action_1_name]
    @action_1_flavor = params[:character][:action_1_flavor]
    @action_1_rules = params[:character][:action_1_rules]
    @action_1_id = Character::getIDnum(@action_1_rules)

    @action_2_name = params[:character][:action_2_name]
    @action_2_flavor = params[:character][:action_2_flavor]
    @action_2_rules = params[:character][:action_2_rules]
    @action_2_id = Character::getIDnum(@action_2_rules)

    @action_3_name = params[:character][:action_3_name]
    @action_3_flavor = params[:character][:action_3_flavor]
    @action_3_rules = params[:character][:action_3_rules]
    @action_3_id = Character::getIDnum(@action_3_rules)

    @action_4_name = params[:character][:action_4_name]
    @action_4_flavor = params[:character][:action_4_flavor]
    @action_4_rules = params[:character][:action_4_rules]
    @action_4_id = Character::getIDnum(@action_4_rules)

    @summon_name = params[:character][:summon_name]
    @summon_picture = params[:character][:summon_picture]
    @summon_attack = params[:character][:summon_attack] 

    @main_image = params[:character][:main_image]
    @actions = @action_1_name + ", " + @action_2_name + ", " + @action_3_name + ", " + @action_4_name
    #binding.pry

    if(!Character.find_by_name(@name).nil?)
      @valid = false
      @string15 = "That character already exists"
    else
	    if(@name.blank?)
	      @valid = false
	      @string1 = "A name must be entered;\n"
	    end
	    if(@description.blank?)
	      @valid = false
	      @string2 = "A description must be entered;\n"
	    end
	    if(@action_1_name.blank?)
	      @valid = false
	      @string3 = "A 1st Action Name must be entered;\n"
	    end
	    if(@action_1_flavor.blank?)
	      @valid = false
	      @string4 = "A 1st Action Description must be entered;\n"
	    end
	    if(@action_2_name.blank?)
	      @valid = false
	      @string5 = "A 2nd Action Name must be entered;\n"
	    end
	    if(@action_2_flavor.blank?)
	      @valid = false
	      @string6 = "A 2nd Action Description must be entered;\n"
	    end
	    if(@action_3_name.blank?)
	      @valid = false
	      @string7 = "A 3rd Action Name must be entered;\n"
	    end
	    if(@action_3_flavor.blank?)
	      @valid = false
	      @string8 = "A 3rd Action Description must be entered;\n"
	    end
	    if(@action_4_name.blank?)
	      @valid = false
	      @string9 = "A 4th Action Name must be entered;\n"
	    end
	    if(@action_4_flavor.blank?)
	      @valid = false
	      @string10 = "A 4th Action Description must be entered;\n"
	    end
	    if(@main_image.blank?)
	      @valid = false
	      @string11 = "A URL for the character image must be entered;\n"
	    end
	    if((@max_hp + @max_mp)>150)
	      @valid = false
	      @string12 = "Sum of Maximum HP and MP must be less than 150;\n"
	    end
	    if((@base_attack + @base_power + @base_defense + @base_armor)>21)
	      @valid = false
	      @string13 = "Sum of base power, attack, defense and armor must be less than 21;\n"
	    end
	    if(@action_1_rules == @action_2_rules || @action_1_rules == @action_3_rules || @action_1_rules == @action_4_rules || @action_2_rules == @action_3_rules || @action_2_rules == @action_4_rules || @action_3_rules == @action_4_rules)
	      @valid = false
	      @string14 = "The rules selected for each action must be different;\n"
	    end 
    end

    if(@valid == false)
      flash[:notice] = "ERROR: " + @string1+@string2+@string3+@string4+@string5+@string6+@string7+@string8+@string9+@string10+@string11+@string12+@string13+@string14+@string15
      redirect_to new_character_path 
    else
      create_hash = {:name => @name, :description => @description, :max_hp => @max_hp, :max_mp => @max_mp, :base_attack => @base_attack, :base_power => @base_power, :base_defense => @base_defense, :base_armor => @base_armor, :actions => @actions, :main_image => @main_image, :action_1_id => @action_1_id, :action_1_name => @action_1_name, :action_1_flavor => @action_1_flavor, :action_1_rules => @action_1_rules, :action_2_id => @action_2_id, :action_2_name => @action_2_name, :action_2_flavor => @action_2_flavor, :action_2_rules => @action_2_rules, :action_3_id => @action_3_id, :action_3_name => @action_3_name, :action_3_flavor => @action_3_flavor, :action_3_rules => @action_3_rules, :action_4_id => @action_4_id, :action_4_name => @action_4_name, :action_4_flavor => @action_4_flavor, :action_4_rules => @action_4_rules, :summon_name => @summon_name, :summon_attack => @summon_attack, :summon_picture => @summon_picture, :creator => player1_username}
      #binding.pry
      Character.create!(create_hash)
      redirect_to select_num_stages_path(:character_name => @name)
    end
  end

  def index
    nm = params[:name]
  #  #binding.pry
    @character = Character.find_by_name(nm)#
    @tag_list = Transformation::get_tag_list(@character.transformation)
    #binding.pry
    #redirect_to characters_show_path(:name => nm)
    #binding.pry
  end

  def update
     x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]
    player1_username = z["username"]
    @valid = true
   
    @string1 = ""
    @string2 = ""
    @string3 = ""
    @string4 = ""
    @string5 = ""
    @string6 = ""
    @string7 = ""
    @string8 = ""
    @string9 = ""
    @string10 = ""
    @string11 = ""
    @string12 = ""
    @string13 = ""
    @string14 = ""
    @string15 = ""

    @name = params[:character][:name]
    @description = params[:character][:description]
    @description = word_wrap(@description)
    @max_hp = params[:character][:max_hp].to_i
    @max_mp = params[:character][:max_mp].to_i
    @base_attack = params[:character][:base_attack].to_i
    @base_power = params[:character][:base_power].to_i
    @base_defense = params[:character][:base_defense].to_i
    @base_armor = params[:character][:base_armor].to_i

    @action_1_name = params[:character][:action_1_name]
    @action_1_flavor = params[:character][:action_1_flavor]
    @action_1_rules = params[:character][:action_1_rules]
    @action_1_id = Character::getIDnum(@action_1_rules)

    @action_2_name = params[:character][:action_2_name]
    @action_2_flavor = params[:character][:action_2_flavor]
    @action_2_rules = params[:character][:action_2_rules]
    @action_2_id = Character::getIDnum(@action_2_rules)

    @action_3_name = params[:character][:action_3_name]
    @action_3_flavor = params[:character][:action_3_flavor]
    @action_3_rules = params[:character][:action_3_rules]
    @action_3_id = Character::getIDnum(@action_3_rules)

    @action_4_name = params[:character][:action_4_name]
    @action_4_flavor = params[:character][:action_4_flavor]
    @action_4_rules = params[:character][:action_4_rules]
    @action_4_id = Character::getIDnum(@action_4_rules)

    @summon_name = params[:character][:summon_name]
    @summon_picture = params[:character][:summon_picture]
    @summon_attack = params[:character][:summon_attack] 

    @main_image = params[:character][:main_image]
    @actions = @action_1_name + ", " + @action_2_name + ", " + @action_3_name + ", " + @action_4_name
    #binding.pry

    #if(!Character.find_by_name(@name).nil?)
      #@valid = false
      #@string15 = "That character already exists"
    #else
    

    if(@name.blank?)
      @valid = false
      @string1 = "A name must be entered;\n"
    end
    if(@description.blank?)
      @valid = false
      @string2 = "A description must be entered;\n"
    end
    if(@action_1_name.blank?)
      @valid = false
      @string3 = "A 1st Action Name must be entered;\n"
    end
    if(@action_1_flavor.blank?)
      @valid = false
      @string4 = "A 1st Action Description must be entered;\n"
    end
    if(@action_2_name.blank?)
      @valid = false
      @string5 = "A 2nd Action Name must be entered;\n"
    end
    if(@action_2_flavor.blank?)
      @valid = false
      @string6 = "A 2nd Action Description must be entered;\n"
     end
    if(@action_3_name.blank?)
      @valid = false
      @string7 = "A 3rd Action Name must be entered;\n"
    end
    if(@action_3_flavor.blank?)
      @valid = false
      @string8 = "A 3rd Action Description must be entered;\n"
    end
    if(@action_4_name.blank?)
      @valid = false
      @string9 = "A 4th Action Name must be entered;\n"
    end
    if(@action_4_flavor.blank?)
      @valid = false
      @string10 = "A 4th Action Description must be entered;\n"
    end
    if(@main_image.blank?)
      @valid = false
      @string11 = "A URL for the character image must be entered;\n"
    end
    if((@max_hp + @max_mp)>150)
      @valid = false
      @string12 = "Sum of Maximum HP and MP must be less than 150;\n"
    end
    if((@base_attack + @base_power + @base_defense + @base_armor)>21)
      @valid = false
      @string13 = "Sum of base power, attack, defense and armor must be less than 21;\n"
    end
    if(@action_1_rules == @action_2_rules || @action_1_rules == @action_3_rules || @action_1_rules == @action_4_rules || @action_2_rules == @action_3_rules || @action_2_rules == @action_4_rules || @action_3_rules == @action_4_rules)
      @valid = false
      @string14 = "The rules selected for each action must be different;\n"
    end 

    if(@valid == false)
      flash[:notice] = "ERROR: " + @string1+@string2+@string3+@string4+@string5+@string6+@string7+@string8+@string9+@string10+@string11+@string12+@string13+@string14+@string15
      redirect_to character_edit_path 
    else
      create_hash = {:name => @name,:description => @description, :max_hp => @max_hp, :max_mp => @max_mp, :base_attack => @base_attack, :base_power => @base_power, :base_defense => @base_defense, :base_armor => @base_armor, :actions => @actions, :main_image => @main_image, :action_1_id => @action_1_id, :action_1_name => @action_1_name, :action_1_flavor => @action_1_flavor, :action_1_rules => @action_1_rules, :action_2_id => @action_2_id, :action_2_name => @action_2_name, :action_2_flavor => @action_2_flavor, :action_2_rules => @action_2_rules, :action_3_id => @action_3_id, :action_3_name => @action_3_name, :action_3_flavor => @action_3_flavor, :action_3_rules => @action_3_rules, :action_4_id => @action_4_id, :action_4_name => @action_4_name, :action_4_flavor => @action_4_flavor, :action_4_rules => @action_4_rules, :summon_name => @summon_name, :summon_attack => @summon_attack, :summon_picture => @summon_picture, :creator => player1_username}
      #binding.pry
      current_character = Character.find_by_name(@name)
      current_character.update_attributes(create_hash)
      current_character.save
      redirect_to game_rules_path
    end
  end

  def destroy
    character = Character.find(params[:id])
    character_name = character.name
    Transformation.delete(character.transformation)
    character.destroy
    search_hash = {:player1_character => character_name}
    delete_list1 = Game.where(search_hash)
    delete_list1.each do |game|
      player1 = User.find_by_username(game.player1)
      player2 = User.find_by_username(game.player2)
      player1.currentgame = nil
      player1.save
      player2.currentgame = nil
      player2.save
      game.destroy
    end

    search_hash = {:player2_character => character_name}
    delete_list2 = Game.where(search_hash)
    delete_list2.each do |game|
      player1 = User.find_by_username(game.player1)
      player2 = User.find_by_username(game.player2)
      player1.currentgame = nil
      player1.save
      player2.currentgame = nil
      player2.save
      game.destroy
    end
    flash[:success] = "Character deleted"
    redirect_to character_admin_path 
  end

  def admin
    if current_user.is_admin
      @characters = Character.all
      #render :template => "/game/admin"
    else
      redirect_to game_rules_path
    end
 end

  def character_select_ai
    #binding.pry
    if params["transformation"].nil?
      @characters = Transformation.all
    else
      #@characters = Transformation.all
      preferences = params["transformation"]
      search_hash = {}
      preferences.each do |key, value|
        if value == "0"
          search_hash[key] = false
        end
      end
      #@characters = Transformation.where(search_hash).order("upvotes DESC")
      @characters = Transformation.where(search_hash).order("created_at DESC")
      #@characters = Hash[@characters.sort_by{|k,v|}, v[:upvotes]]
     
      #binding.pry
      if @characters.empty?
        flash[:notice] = "No Results Found"
      end

      @rules_hash = search_hash
      #binding.pry
    end
  end

  def select_opponent
    @player1_character = params[:name]
    if params["transformation"].nil?
      @characters = Transformation.all
    else
      #@characters = Transformation.all
      preferences = params["transformation"]
      search_hash = {}
      preferences.each do |key, value|
        if value == "0"
          search_hash[key] = false
        end
      end
      @characters = Transformation.where(search_hash).order("upvotes ASC")
      #binding.pry
      if @characters.empty?
        flash[:notice] = "No Results Found"
      end

      @rules_hash = search_hash
      #binding.pry
    end
  end

  def edit
    @character = Character.find_by_name(params[:name])
  end

  def show
    #binding.pry
    @character = Character.find_by_name(params[:name])
    if @character.nil?
      flash[:notice] = "This Character Does Not Have an Associated Transformation"
      redirect_to character_admin_path
    else
      @tag_list = Transformation::get_tag_list(@character.transformation)
    end
  end
end
