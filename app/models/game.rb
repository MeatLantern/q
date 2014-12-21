class Game < ActiveRecord::Base
  attr_protected

  def Game::take_action(action_id, current_game)


  	#Determine if it is Player 1's Turn or Player 2's Turn
  	turn = current_game.current_turn % 2
  	if (turn == 1)
  		p1_turn = true
  	else
  		p1_turn = false
  	end


    if(p1_turn)
      active_character = Character.find_by_name(current_game.player1_character)
      passive_character = Character.find_by_name(current_game.player2_character)
    else
      active_character = Character.find_by_name(current_game.player2_character)
      passive_character = Character.find_by_name(current_game.player1_character)
    end


    buff_results = Game::handle_buff_effects(current_game, p1_turn, active_character)

    debuff_results = Game::handle_debuff_effects(current_game, p1_turn, action_id, active_character)

    #Handle Confusion
    if(p1_turn)
      if(current_game.player1_debuff == "Confusion")
        if debuff_results.include?("random")
          ai_character = active_character
          action_array = ["1","2","3", ai_character.action_1_id, ai_character.action_2_id, ai_character.action_3_id, ai_character.action_4_id]
          action_temp = action_array.sample
          action_id = "#{action_temp}"
        end
      end
    else
      if(current_game.player2_debuff == "Confusion")
        if debuff_results.include?("random")
          ai_character = active_character
          action_array = ["1","2","3", ai_character.action_1_id, ai_character.action_2_id, ai_character.action_3_id, ai_character.action_4_id]
          action_temp = action_array.sample
          action_id = "#{action_temp}"
        end
      end
    end

    #Obtain Bonuses
    attack_bonus = active_character.base_attack
    if p1_turn
      if(current_game.player1_buff == "Attack UP")
        attack_bonus = attack_bonus + 2
      elsif (current_game.player1_debuff == "Attack DOWN")
        attack_bonus = attack_bonus -2
      end
    else
      if(current_game.player2_buff == "Attack UP")
        attack_bonus = attack_bonus + 2
      elsif (current_game.player2_debuff == "Attack DOWN")
        attack_bonus = attack_bonus -2
      end
    end
    damage_bonus = active_character.base_power
    if p1_turn
      if(current_game.player1_buff == "Power UP")
        damage_bonus = damage_bonus + 2
      elsif (current_game.player1_debuff == "Power DOWN")
        damage_bonus = damage_bonus -2
      end
    else
      if(current_game.player2_buff == "Power UP")
        damage_bonus = damage_bonus + 2
      elsif (current_game.player2_debuff == "Power DOWN")
        damage_bonus = damage_bonus -2
      end
    end
    armor_bonus = passive_character.base_armor
    if p1_turn
      if(current_game.player2_buff == "Armor UP")
        armor_bonus = armork_bonus + 2
      elsif (current_game.player2_debuff == "Armor DOWN")
        armor_bonus = armor_bonus -2
      end
    else
      if(current_game.player1_buff == "Armor UP")
        armor_bonus = armor_bonus + 2
      elsif (current_game.player1_debuff == "Armor DOWN")
        armor_bonus = armor_bonus -2
      end
    end
    defense_bonus = passive_character.base_defense
    if p1_turn
      if(current_game.player2_buff == "Defense UP")
        defense_bonus = defense_bonus + 2
      elsif (current_game.player2_debuff == "Defense DOWN")
        defense_bonus = defense_bonus -2
      end
    else
      if(current_game.player1_buff == "Defense UP")
        defense_bonus = defense_bonus + 2
      elsif (current_game.player1_debuff == "Defense DOWN")
        defense_bonus = defense_bonus -2
      end
    end

    #Handle Summons
    summon_results = Game::summon_handler(defense_bonus, armor_bonus, p1_turn, current_game, active_character)

  	#Action 1: Basic Attack
  	if(action_id == "1")
  		#Pull Neccesary stats from the characters
  		#attack_bonus = active_character.base_attack
  		#damage_bonus = active_character.base_power
  		#armor_bonus = passive_character.base_armor
  		#defense_bonus = passive_character.base_defense
  		action_results = Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
  	end

    #Action 3: Focus (Regain Mana)
    if(action_id == "3")
      mana_regained = active_character.max_mp / 5
      if (p1_turn)
        current_game.p1_mp = current_game.p1_mp + mana_regained
        if (current_game.p1_mp > active_character.max_mp)
          current_game.p1_mp = active_character.max_mp
        end
      else
        current_game.p2_mp = current_game.p2_mp + mana_regained
        if (current_game.p2_mp > active_character.max_mp)
          current_game.p2_mp = active_character.max_mp
        end
      end
      action_results = "#{active_character.name} focuses, gaining #{mana_regained} mana."
      current_game.save
      #action_results = Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
    end

    #Action 4:Accurate Attack
    if(action_id == "4")
      #Pull Neccesary stats from the characters
      #attack_bonus = active_character.base_attack + 3
      #damage_bonus = active_character.base_power
      #armor_bonus = passive_character.base_armor
      #defense_bonus = passive_character.base_defense
      if(p1_turn)
        action_results = "#{active_character.name} uses a more accurate attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 10
          attack_bonus = attack_bonus + 3
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          current_game.p1_mp = current_game.p1_mp - 10
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses a more accurate attack!"
         if current_game.p2_mp >= 10
          attack_bonus = attack_bonus + 3
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          current_game.p2_mp = current_game.p2_mp - 10
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
      #Subtract Mana
    end

    #Action 4:Powerful Attack
    if(action_id == "5")
      #Pull Neccesary stats from the characters
      #attack_bonus = active_character.base_attack
      #damage_bonus = active_character.base_power + 3
      #armor_bonus = passive_character.base_armor
      #defense_bonus = passive_character.base_defense
       if(p1_turn)
        action_results = "#{active_character.name} uses a more damaging attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 10
          damage_bonus = damage_bonus + 3
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          current_game.p1_mp = current_game.p1_mp - 10
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses a more damaging attack!"
         if current_game.p2_mp >= 10
          damage_bonus = damage_bonus + 3
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          current_game.p2_mp = current_game.p2_mp - 10
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

    if(action_id == "6")
      #Pull Neccesary stats from the characters
      #attack_bonus = active_character.base_attack
      #damage_bonus = active_character.base_power + 3
      #armor_bonus = passive_character.base_armor
      #defense_bonus = passive_character.base_defense
       if(p1_turn)
        action_results = "#{active_character.name} attacks recklessly!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 10
          damage_bonus = damage_bonus + 5
          attack_bonus = attack_bonus - 2
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          current_game.p1_mp = current_game.p1_mp - 10
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} attacks recklessly!"
         if current_game.p2_mp >= 10
          damage_bonus = damage_bonus + 5
          attack_bonus = attack_bonus - 2
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          current_game.p2_mp = current_game.p2_mp - 10
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Action 6:Overwhelming Attack
    if(action_id == "7")
      #Pull Neccesary stats from the characters
      #attack_bonus = active_character.base_attack
      #damage_bonus = active_character.base_power + 3
      #armor_bonus = passive_character.base_armor
      #defense_bonus = passive_character.base_defense
       if(p1_turn)
        action_results = "#{active_character.name} uses an overwhelming attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 20
          damage_bonus = damage_bonus + 4
          attack_bonus = attack_bonus + 3
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses an overwhelming attack!"
         if current_game.p2_mp >= 20
          damage_bonus = damage_bonus + 4
          attack_bonus = attack_bonus + 3
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Action 13: Poisoning Attack
    if(action_id == "13")
      if(p1_turn)
        action_results = "#{active_character.name} uses a poisoning attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player2_debuff = "Poison"
            current_game.player2_debuff_start = current_game.current_turn
          end
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses a poisoning attack!"
         if current_game.p2_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player1_debuff = "Poison"
            current_game.player1_debuff_start = current_game.current_turn
          end
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Action 14: Silencing Attack
    if(action_id == "14")
      if(p1_turn)
        action_results = "#{active_character.name} uses a silencing attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player2_debuff = "Silence"
            current_game.player2_debuff_start = current_game.current_turn
          end
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses a silencing attack!"
         if current_game.p2_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player1_debuff = "Silence"
            current_game.player1_debuff_start = current_game.current_turn
          end
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

     #Action 15: Confusing Attack
    if(action_id == "15")
      if(p1_turn)
        action_results = "#{active_character.name} uses a Confusion-inducing attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player2_debuff = "Confusion"
            current_game.player2_debuff_start = current_game.current_turn
          end
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses a Confusion-inducing attack!"
         if current_game.p2_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player1_debuff = "Confusion"
            current_game.player1_debuff_start = current_game.current_turn
          end
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Action 16: Locking Attack
    if(action_id == "16")
      if(p1_turn)
        action_results = "#{active_character.name} uses a mana locking attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player2_debuff = "Mana Lock"
            current_game.player2_debuff_start = current_game.current_turn
          end
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses a mana locking attack!"
         if current_game.p2_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player1_debuff = "Mana Lock"
            current_game.player1_debuff_start = current_game.current_turn
          end
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

     #Action 16: Defense Break Attack
    if(action_id == "17")
      if(p1_turn)
        action_results = "#{active_character.name} uses a defense breaking attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player2_debuff = "Defense DOWN"
            current_game.player2_debuff_start = current_game.current_turn
          end
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses a defense breaking attack!"
         if current_game.p2_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player1_debuff = "Defense DOWN"
            current_game.player1_debuff_start = current_game.current_turn
          end
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

     #Action 18: Armor Break Attack
    if(action_id == "18")
      if(p1_turn)
        action_results = "#{active_character.name} uses an armor breaking attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player2_debuff = "Armor DOWN"
            current_game.player2_debuff_start = current_game.current_turn
          end
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses an armor breaking attack!"
         if current_game.p2_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player1_debuff = "Armor DOWN"
            current_game.player1_debuff_start = current_game.current_turn
          end
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

     #Action 19: Attack Break Attack
    if(action_id == "19")
      if(p1_turn)
        action_results = "#{active_character.name} uses an attack-breaking attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player2_debuff = "Attack DOWN"
            current_game.player2_debuff_start = current_game.current_turn
          end
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses an attack-breaking attack!"
         if current_game.p2_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player1_debuff = "Defense DOWN"
            current_game.player1_debuff_start = current_game.current_turn
          end
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

     #Action 16: Defense Break Attack
    if(action_id == "20")
      if(p1_turn)
        action_results = "#{active_character.name} uses a power breaking attack!"
        #Check if Player has enough mana.
        if current_game.p1_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player2_debuff = "Power DOWN"
            current_game.player2_debuff_start = current_game.current_turn
          end
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      else
         action_results = "#{active_character.name} uses a power breaking attack!"
         if current_game.p2_mp >= 20
          action_results = action_results + Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
          if (action_results.include? "Successful")
            current_game.player1_debuff = "Power DOWN"
            current_game.player1_debuff_start = current_game.current_turn
          end
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = action_results + "Action Failed! #{active_character.name} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Focusing Action for Mana Regen
    if(action_id == "8")
      if(p1_turn)
        if(current_game.p1_mp >= 10)
          action_results = "#{current_game.player1_character} will now gain mana every turn."
          current_game.player1_buff = "Mana Regeneration"
          current_game.player1_buff_start = current_game.current_turn
          current_game.p1_mp = current_game.p1_mp - 10
        else
          action_results = "#{current_game.player1_character} doesn't have enough Mana to activate the power!"
        end
      else
        if(current_game.p2_mp >= 10)
          action_results = "#{current_game.player2_character} will now gain mana every turn."
          current_game.player2_buff = "Mana Regeneration"
          current_game.player2_buff_start = current_game.current_turn
          current_game.p2_mp = current_game.p2_mp - 10
        else
          action_results = "#{current_game.player2_character} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Action 9: Defense UP
    if(action_id == "9")
      if(p1_turn)
        if(current_game.p1_mp >= 10)
          action_results = "#{current_game.player1_character} has increased defense."
          current_game.player1_buff = "Defense UP"
          current_game.player1_buff_start = current_game.current_turn
          current_game.p1_mp = current_game.p1_mp - 10
        else
          action_results = "#{current_game.player1_character} doesn't have enough Mana to activate the power!"
        end
      else
        if(current_game.p2_mp >= 10)
          action_results = "#{current_game.player2_character} has increased defense."
          current_game.player2_buff = "Defense UP"
          current_game.player2_buff_start = current_game.current_turn
          current_game.p2_mp = current_game.p2_mp - 10
        else
          action_results = "#{current_game.player2_character} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Action 10: Attack UP
    if(action_id == "10")
      if(p1_turn)
        if(current_game.p1_mp >= 10)
          action_results = "#{current_game.player1_character} has increased attack."
          current_game.player1_buff = "Attack UP"
          current_game.player1_buff_start = current_game.current_turn
          current_game.p1_mp = current_game.p1_mp - 10
        else
          action_results = "#{current_game.player1_character} doesn't have enough Mana to activate the power!"
        end
      else
        if(current_game.p2_mp >= 10)
          action_results = "#{current_game.player2_character} has increased attack."
          current_game.player2_buff = "Attack UP"
          current_game.player2_buff_start = current_game.current_turn
          current_game.p2_mp = current_game.p2_mp - 10
        else
          action_results = "#{current_game.player2_character} doesn't have enough Mana to activate the power!"
        end
      end
    end

     #Action 11: Armor UP
    if(action_id == "11")
      if(p1_turn)
        if(current_game.p1_mp >= 10)
          action_results = "#{current_game.player1_character} has increased armor."
          current_game.player1_buff = "Armor UP"
          current_game.player1_buff_start = current_game.current_turn
          current_game.p1_mp = current_game.p1_mp - 10
        else
          action_results = "#{current_game.player1_character} doesn't have enough Mana to activate the power!"
        end
      else
        if(current_game.p2_mp >= 10)
          action_results = "#{current_game.player2_character} has increased armor."
          current_game.player2_buff = "Armor UP"
          current_game.player2_buff_start = current_game.current_turn
          current_game.p2_mp = current_game.p2_mp - 10
        else
          action_results = "#{current_game.player2_character} doesn't have enough Mana to activate the power!"
        end
      end
    end

     #Action 12: Power UP
    if(action_id == "12")
      if(p1_turn)
        if(current_game.p1_mp >= 10)
          action_results = "#{current_game.player1_character} has increased damage."
          current_game.player1_buff = "Power UP"
          current_game.player1_buff_start = current_game.current_turn
          current_game.p1_mp = current_game.p1_mp - 10
        else
          action_results = "#{current_game.player1_character} doesn't have enough Mana to activate the power!"
        end
      else
        if(current_game.p2_mp >= 10)
          action_results = "#{current_game.player2_character} has increased damage."
          current_game.player2_buff = "Power UP"
          current_game.player2_buff_start = current_game.current_turn
          current_game.p2_mp = current_game.p2_mp - 10
        else
          action_results = "#{current_game.player2_character} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Action 21: Charge
    if(action_id == "21")
      if(p1_turn)
        if(current_game.p1_mp >= 20)
          action_results = "#{current_game.player1_character} has charged up their attack. Their next attack's damage will be doubled!"
          current_game.player1_buff = "Charge"
          current_game.player1_buff_start = current_game.current_turn
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = "#{current_game.player1_character} doesn't have enough Mana to activate the power!"
        end
      else
        if(current_game.p2_mp >= 20)
          action_results = "#{current_game.player2_character} has  has charged up their attack. Their next attack's damage will be doubled!"
          current_game.player2_buff = "Charge"
          current_game.player2_buff_start = current_game.current_turn
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = "#{current_game.player2_character} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Action 22: Summon
    if(action_id == "22")
      if(p1_turn)
        if(current_game.p1_mp >= 20)
          action_results = "#{current_game.player1_character} has summoned an ally!"
          current_game.player1_buff = "Summon"
          current_game.player1_buff_start = current_game.current_turn
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = "#{current_game.player1_character} doesn't have enough Mana to activate the power!"
        end
      else
        if(current_game.p2_mp >= 20)
          action_results = "#{current_game.player2_character} has summoned an ally!"
          current_game.player2_buff = "Summon"
          current_game.player2_buff_start = current_game.current_turn
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = "#{current_game.player2_character} doesn't have enough Mana to activate the power!"
        end
      end
    end

    #Action 23: Heal (Regain Health)
    if(action_id == "23")
      health_regained = 5 + rand(10)
      if (p1_turn)
        if (current_game.p1_mp >= 20)
          current_game.p1_hp = current_game.p1_hp + health_regained
          action_results = "#{active_character.name} heals, gaining #{health_regained} Hit Points."
          if (current_game.p1_hp > active_character.max_hp)
            current_game.p1_hp = active_character.max_hp
          end
          current_game.p1_mp = current_game.p1_mp - 20
        else
          action_results = "#{current_game.player1_character} doesn't have enough Mana to activate the power!"
        end

      else
        if (current_game.p2_mp >= 20)
          current_game.p2_hp = current_game.p2_hp + health_regained
          action_results = "#{active_character.name} heals, gaining #{health_regained} Hit Points."
          if (current_game.p2_hp > active_character.max_hp)
            current_game.p2_hp = active_character.max_hp
          end
          current_game.p2_mp = current_game.p2_mp - 20
        else
          action_results = "#{current_game.player2_character} doesn't have enough Mana to activate the power!"
        end
      end
     
      current_game.save
      #action_results = Game::basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
    end
  	
  	#The Guard Needs to be removed after all other actions are complete.
  	current_game.p1_guard = false
  	current_game.p2_guard = false

  	#binding.pry

	#The Guard action must be taken last so that it can affect the next action  	
  	if(action_id == "2")
  		turn = current_game.current_turn
  		if (turn % 2 == 1)
  			current_game.p1_guard = true
  			action_results = "Guard Activated!"
  		else
  			current_game.p2_guard = true
  			action_results = "Guard Activated!"
  		end
  	end

  	#End of Turn Checks for Status etc.
  	current_game.current_turn = current_game.current_turn + 1

  	#Check if Player 1 is Dead
  	if (current_game.p1_hp <= 0)
  		current_game.game_over = true
  		win_results = "#{current_game.player1} Loses!"
  	end
  	#Check if Player 2 is dead
  	if (current_game.p2_hp <= 0)
  		current_game.game_over = true
  		win_results = "#{current_game.player2} Loses!"
  	end

  	current_game.save

    results = "#{buff_results} \n #{summon_results} \n #{debuff_results} \n #{action_results} \n  #{win_results}"

  	return results

  end

  def Game::handle_debuff_effects(current_game, p1_turn, action_id, active_character)

    if (p1_turn)
      #Handle Poison Status Effect
      if (current_game.player1_debuff == "Poison")
        
        duration = current_game.current_turn - current_game.player1_debuff_start
        if duration > 5
          current_game.player1_debuff = "None"
          current_game.player1_debuff_start = -50
          results = "#{current_game.player1_character} has finally overcome the poison!"
          current_game.save
        else
          poison_damage = 3 + rand(6)
          current_game.p1_hp = current_game.p1_hp - poison_damage
          results = "#{current_game.player1_character} has taken #{poison_damage} from the poison!"
        end

      end

      #Handle Confusion Status Effect
      if (current_game.player1_debuff == "Confusion")
        
        duration = current_game.current_turn - current_game.player1_debuff_start
        if duration > 6
          current_game.player1_debuff = "None"
          current_game.player1_debuff_start = -50
          results = "#{current_game.player1_character} is no longer confused!"
        else
          c_rating = 1 + rand(10)
          if(c_rating < 2)
            results = "#{current_game.player1_character} dances around like a lunatic."
          elsif (c_rating < 8)
            results = "Due to #{current_game.player1_character}'s Confusion they took a random action!"
          else
            results = "#{current_game.player1_character}'s confusion didn't affect the action."
          end
        end
      end

      if (current_game.player1_debuff == "Silence")   
        duration = current_game.current_turn - current_game.player1_debuff_start
        if duration > 4
          current_game.player1_debuff = "None"
          current_game.player1_debuff_start = -50
          results = "#{current_game.player1_character} is no longer silenced!"
          current_game.save
        else
          results = "#{current_game.player1_character} is silenced and unable to use special attacks!"
        end
      end

      if (current_game.player1_debuff == "Mana Lock")   
        duration = current_game.current_turn - current_game.player1_debuff_start
        if duration > 6
          current_game.player1_debuff = "None"
          current_game.player1_debuff_start = -50
          results = "#{current_game.player1_character} has overcome the Mana Lock."
          current_game.save
        else
          max_mp = active_character.max_mp
          mana_regained = max_mp / 10
          current_game.p1_mp = current_game.p1_mp - mana_regained
          if(current_game.p1_mp < 0)
            current_game.p1_mp = 0
          end
          results = "#{current_game.player1_character} has lost #{mana_regained} mana from the Mana Lock!"
          current_game.save
        end
      end

      if (current_game.player1_debuff == "Attack DOWN")   
        duration = current_game.current_turn - current_game.player1_debuff_start
        if duration > 6
          current_game.player1_debuff = "None"
          current_game.player1_debuff_start = -50
          results = "#{current_game.player1_character}'s attack has returned to normal."
          current_game.save
        else
          results = "#{current_game.player1_character}'s' attack is weakened."
        end
      end

      if (current_game.player1_debuff == "Defense DOWN")   
        duration = current_game.current_turn - current_game.player1_debuff_start
        if duration > 6
          current_game.player1_debuff = "None"
          current_game.player1_debuff_start = -50
          results = "#{current_game.player1_character}'s defense has returned to normal."
          current_game.save
        else
          results = "#{current_game.player1_character}'s' defense is weakened."
        end
      end

      if (current_game.player1_debuff == "Power DOWN")   
        duration = current_game.current_turn - current_game.player1_debuff_start
        if duration > 6
          current_game.player1_debuff = "None"
          current_game.player1_debuff_start = -50
          results = "#{current_game.player1_character}'s power has returned to normal."
          current_game.save
        else
          results = "#{current_game.player1_character}'s' power is weakened."
        end
      end

      if (current_game.player1_debuff == "Armor DOWN")   
        duration = current_game.current_turn - current_game.player1_debuff_start
        if duration > 6
          current_game.player1_debuff = "None"
          current_game.player1_debuff_start = -50
          results = "#{current_game.player1_character}'s armor has returned to normal."
          current_game.save
        else
          results = "#{current_game.player1_character}'s' armor is weakened."
        end
      end

    else
        #Handle Poison Status Effect
      if (current_game.player2_debuff == "Poison")
        
        duration = current_game.current_turn - current_game.player2_debuff_start
        if duration > 5
          current_game.player2_debuff = "None"
          current_game.player2_debuff_start = -50
          results = "#{current_game.player2_character} has finally overcome the poison!"
        else
          poison_damage = 3 + rand(6)
          current_game.p2_hp = current_game.p2_hp - poison_damage
          results = "#{current_game.player2_character} has taken #{poison_damage} damage from the poison!"
        end

      end

      #Handle Confusion Status Effect
      if (current_game.player2_debuff == "Confusion")
        duration = current_game.current_turn - current_game.player2_debuff_start
        if duration > 5
          current_game.player2_debuff = "None"
          current_game.player2_debuff_start = -50
          results = "#{current_game.player2_character} is no longer confused!"
        else
          c_rating = 1 + rand(10)
          if(c_rating < 2)
            results = "#{current_game.player2_character} dances around like a lunatic."
          elsif (c_rating < 8)
            results = "Due to #{current_game.player2_character}'s Confusion they took a random action!"
          else
            results = "#{current_game.player2_character}'s confusion didn't affect the action."
          end
        end
      end

      if (current_game.player2_debuff == "Silence")   
        duration = current_game.current_turn - current_game.player2_debuff_start
        if duration > 4
          current_game.player2_debuff = "None"
          current_game.player2_debuff_start = -50
          results = "#{current_game.player2_character} is no longer silenced!"
          current_game.save
        else
          results = "#{current_game.player2_character} is silenced and unable to use special attacks!"
        end
      end

      if (current_game.player2_debuff == "Mana Lock")   
        duration = current_game.current_turn - current_game.player2_debuff_start
        if duration > 6
          current_game.player2_debuff = "None"
          current_game.player2_debuff_start = -50
          results = "#{current_game.player2_character} has overcome the Mana Lock"
          current_game.save
        else
          max_mp = active_character.max_mp
          mana_regained = max_mp / 10
          current_game.p2_mp = current_game.p2_mp - mana_regained
          if(current_game.p2_mp < 0)
            current_game.p2_mp = 0
          end
          results = "#{current_game.player2_character} has lost #{mana_regained} mana from the Mana Lock!"
          current_game.save
        end
      end

      if (current_game.player2_debuff == "Attack DOWN")   
        duration = current_game.current_turn - current_game.player2_debuff_start
        if duration > 6
          current_game.player2_debuff = "None"
          current_game.player2_debuff_start = -50
          results = "#{current_game.player2_character}'s attack has returned to normal."
          current_game.save
        else
          results = "#{current_game.player2_character}'s' attack is weakened."
        end
      end

      if (current_game.player2_debuff == "Defense DOWN")   
        duration = current_game.current_turn - current_game.player2_debuff_start
        if duration > 6
          current_game.player2_debuff = "None"
          current_game.player2_debuff_start = -50
          results = "#{current_game.player2_character}'s defense has returned to normal."
          current_game.save
        else
          results = "#{current_game.player2_character}'s' defense is weakened."
        end
      end

      if (current_game.player2_debuff == "Power DOWN")   
        duration = current_game.current_turn - current_game.player2_debuff_start
        if duration > 6
          current_game.player2_debuff = "None"
          current_game.player2_debuff_start = -50
          results = "#{current_game.player2_character}'s power has returned to normal."
          current_game.save
        else
          results = "#{current_game.player2_character}'s' power is weakened."
        end
      end

      if (current_game.player2_debuff == "Armor DOWN")   
        duration = current_game.current_turn - current_game.player2_debuff_start
        if duration > 6
          current_game.player2_debuff = "None"
          current_game.player2_debuff_start = -50
          results = "#{current_game.player2_character}'s armor has returned to normal."
          current_game.save
        else
          results = "#{current_game.player2_character}'s' armor is weakened."
        end
      end

    end 

    current_game.save
    return results
  end

  def Game::handle_buff_effects(current_game, p1_turn, active_character)
    if p1_turn

      if (current_game.player1_buff == "Attack UP")   
        duration = current_game.current_turn - current_game.player1_buff_start
        if duration > 6
          current_game.player1_buff = "None"
          current_game.player1_buff_start = -50
          results = "#{current_game.player1_character}'s attack has returned to normal."
          current_game.save
        else
          results = "#{current_game.player1_character}'s' attack is strengthened."
        end
      end

      if (current_game.player1_buff == "Defense UP")   
        duration = current_game.current_turn - current_game.player1_buff_start
        if duration > 6
          current_game.player1_buff = "None"
          current_game.player1_buff_start = -50
          results = "#{current_game.player1_character}'s defense has returned to normal."
          current_game.save
        else
          results = "#{current_game.player1_character}'s' defense is strengthened."
        end
      end

      if (current_game.player1_buff == "Power UP")   
        duration = current_game.current_turn - current_game.player1_buff_start
        if duration > 6
          current_game.player1_buff = "None"
          current_game.player1_buff_start = -50
          results = "#{current_game.player1_character}'s power has returned to normal."
          current_game.save
        else
          results = "#{current_game.player1_character}'s' power is strengthened."
        end
      end

      if (current_game.player1_buff == "Armor UP")   
        duration = current_game.current_turn - current_game.player1_buff_start
        if duration > 6
          current_game.player1_buff = "None"
          current_game.player1_buff_start = -50
          results = "#{current_game.player1_character}'s armor has returned to normal."
          current_game.save
        else
          results = "#{current_game.player1_character}'s' armor is strengthened."
        end
      end

      if (current_game.player1_buff == "Mana Regeneration")   
        duration = current_game.current_turn - current_game.player1_buff_start
        if duration > 6
          current_game.player1_buff = "None"
          current_game.player1_buff_start = -50
          results = "#{current_game.player1_character} has lost their Mana Regeneration"
          current_game.save
        else
          max_mp = active_character.max_mp
          mana_regained = max_mp / 10
          current_game.p1_mp = current_game.p1_mp + mana_regained
          if(current_game.p1_mp > max_mp)
            current_game.p1_mp = max_mp
          end
          results = "#{current_game.player1_character} has regained #{mana_regained} mana."
          current_game.save
        end
      end

      if (current_game.player1_buff == "Charge")   
        duration = current_game.current_turn - current_game.player1_buff_start
        if duration > 2
          current_game.player1_buff = "None"
          current_game.player1_buff_start = -50
          results = "#{current_game.player1_character} has lost their power charge."
          current_game.save
        else
          results = "#{current_game.player1_character} is charged up!"
        end
      end

      return results
    else

      if (current_game.player2_buff == "Attack UP")   
        duration = current_game.current_turn - current_game.player2_buff_start
        if duration > 6
          current_game.player2_buff = "None"
          current_game.player2_buff_start = -50
          results = "#{current_game.player2_character}'s attack has returned to normal."
          current_game.save
        else
          results = "#{current_game.player2_character}'s' attack is strengthened."
        end
      end

      if (current_game.player2_buff == "Defense UP")   
        duration = current_game.current_turn - current_game.player2_buff_start
        if duration > 6
          current_game.player2_buff = "None"
          current_game.player2_buff_start = -50
          results = "#{current_game.player2_character}'s defense has returned to normal."
          current_game.save
        else
          results = "#{current_game.player2_character}'s' defense is strengthened."
        end
      end

      if (current_game.player2_buff == "Power UP")   
        duration = current_game.current_turn - current_game.player2_buff_start
        if duration > 6
          current_game.player2_buff = "None"
          current_game.player2_buff_start = -50
          results = "#{current_game.player2_character}'s power has returned to normal."
          current_game.save
        else
          results = "#{current_game.player2_character}'s' power is strengthened."
        end
      end

      if (current_game.player2_buff == "Armor UP")   
        duration = current_game.current_turn - current_game.player2_buff_start
        if duration > 6
          current_game.player2_buff = "None"
          current_game.player2_buff_start = -50
          results = "#{current_game.player2_character}'s armor has returned to normal."
          current_game.save
        else
          results = "#{current_game.player2_character}'s' armor is strengthened."
        end
      end

      if (current_game.player2_buff == "Mana Regeneration")   
        duration = current_game.current_turn - current_game.player2_buff_start
        if duration > 6
          current_game.player2_buff = "None"
          current_game.player2_buff_start = -50
          results = "#{current_game.player2_character} has lost their Mana Regeneration."
          current_game.save
        else
          max_mp = active_character.max_mp
          mana_regained = max_mp / 10
          current_game.p2_mp = current_game.p2_mp + mana_regained
          if(current_game.p2_mp > max_mp)
            current_game.p2_mp = max_mp
          end
          results = "#{current_game.player2_character} has regained #{mana_regained} mana."
          current_game.save
        end
      end

      if (current_game.player2_buff == "Charge")   
        duration = current_game.current_turn - current_game.player2_buff_start
        if duration > 2
          current_game.player2_buff = "None"
          current_game.player2_buff_start = -50
          results = "#{current_game.player2_character} has lost their charge."
          current_game.save
        else
          results = "#{current_game.player2_character} is charged up!"
        end
      end

    return results
    end    
  end

  def Game::summon_handler(defense_bonus, armor_bonus, p1_turn, current_game, active_character)
    if (p1_turn)
      if (current_game.player1_buff == "Summon")   
          duration = current_game.current_turn - current_game.player1_buff_start
          if duration > 10
            current_game.player1_buff = "None"
            current_game.player1_buff_start = -50
            results = "#{current_game.player1_character}'s summon has been dismissed."
            current_game.save
          else
            attack_bonus = 5
            damage_bonus = 5
            results = Game::summon_basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game, active_character)
            current_game.save
          end
      return results
      end
    else
        if (current_game.player2_buff == "Summon")   
          duration = current_game.current_turn - current_game.player2_buff_start
          if duration > 10
            current_game.player2_buff = "None"
            current_game.player2_buff_start = -50
            results = "#{current_game.player2_character}'s summon has been dismissed."
            current_game.save
          else
            attack_bonus = 5
            damage_bonus = 5
            results = Game::summon_basic_attack(attack_bonus, defense_bonus, damage_bonus, armor_bonus, p1_turn, current_game)
            current_game.save
          end
      return results
      end
    end
  end

  def Game::basic_attack(attack_bonus, defense_bonus, power_bonus, armor_bonus, p1_turn, current_game)

  	#Make Attack Roll
  	attack_roll = 1 + rand(20) + attack_bonus

  	#Check for Guarding
  	if(p1_turn)
  		if(current_game.p2_guard == "t")
  			defense_bonus = defense_bonus + 3
  			armor_bonus = armor_bonus + 3
  		end
  	else
  		if(current_game.p1_guard == "t")
  			defense_bonus = defense_bonus + 3
  			armor_bonus = armor_bonus + 3
  		end
  	end

  	#binding.pry

  	#Check if hit
  	if(attack_roll > 10 + defense_bonus)
  		#Determine Damage
  		damage = 2 + rand(10) + power_bonus - armor_bonus
  		if damage < 0
  			damage = 0
  		end
      if(p1_turn)
        if current_game.player1_buff == "Charge"
          damage = damage * 2
        end
      else
        if current_game.player2_buff == "Charge"
          damage = damage * 2
        end
      end
  		#Apply damage
  		if(p1_turn)
  		   current_game.p2_hp = current_game.p2_hp - damage
  		else
  		   current_game.p1_hp = current_game.p1_hp - damage
  		end
  		results = "Attack Successful! #{damage} damage dealt!"
  	else
  		results = "Attack Failed! No damage dealt."
  	end
  	#binding.pry
  	current_game.save
  	return results
  end

  def Game::summon_basic_attack(attack_bonus, defense_bonus, power_bonus, armor_bonus, p1_turn, current_game, active_character)

    #Get Characters
    #player1_character = Character.find_by_name(current_game.player1_character)
    #player2_character = Character.find_by_name(current_game.player2_character)
    #Make Attack Roll
    attack_roll = 1 + rand(20) + attack_bonus

    #Check for Guarding
    if(p1_turn)
      if(current_game.p2_guard == "t")
        defense_bonus = defense_bonus + 3
        armor_bonus = armor_bonus + 3
      end
    else
      if(current_game.p1_guard == "t")
        defense_bonus = defense_bonus + 3
        armor_bonus = armor_bonus + 3
      end
    end

    #binding.pry

    #Check if hit
    if(attack_roll > 10 + defense_bonus)
      #Determine Damage
      damage = 2 + rand(10) + power_bonus - armor_bonus
      if damage < 0
        damage = 0
      end
      #Apply damage
      if(p1_turn)
         current_game.p2_hp = current_game.p2_hp - damage
         results = "#{active_character.summon_attack} The Summon's Attack was Successful! #{damage} damage dealt!"
      else
         current_game.p1_hp = current_game.p1_hp - damage
         results = "#{active_character.summon_attack} The Summon's Attack was Successful! #{damage} damage dealt!"
      end
      
    else
      results = "The Summon's Attack Failed! No damage dealt."
    end
    #binding.pry
    current_game.save
    return results
  end

  def Game::get_MP_cost(action_id)
   if action_id == 4
    return  10
   elsif action_id == 5
    return 10
   elsif action_id == 6
    return 10
   elsif action_id == 7
    return 20 
   elsif action_id == 8
    return 10
   elsif action_id == 9
    return 10
   elsif action_id == 10
    return 10
   elsif action_id == 11
    return 10
   elsif action_id == 12
    return 10
   elsif action_id == 13
    return 20
   elsif action_id == 14
    return 20
   elsif action_id == 15
    return 20
   elsif action_id == 16
    return 20
   elsif action_id == 17
    return 15
   elsif action_id == 18
    return 15
   elsif action_id == 19
    return 15
   elsif action_id == 20
    return 15
   elsif action_id == 21
    return 15
   elsif action_id == 22
    return 20
   elsif action_id == 23
    return 20
   end     
 end

 def Game::get_ability_info (action_id, character_name)
  current_character = Character.find_by_name(character_name)
  answer = Hash.new()

  #binding.pry

  if "#{current_character.action_1_id}" == "#{action_id}"
    answer = {"ability_name" => current_character.action_1_name, "ability_flavor" => current_character.action_1_flavor}
    return answer
  end
   
  if "#{current_character.action_2_id}" == "#{action_id}"
    answer = {"ability_name" => current_character.action_2_name, "ability_flavor" => current_character.action_2_flavor}
    return answer
  end

  if "#{current_character.action_3_id}" == "#{action_id}"
    answer = {"ability_name" => current_character.action_3_name, "ability_flavor" => current_character.action_3_flavor}
    return answer
  end

  if "#{current_character.action_4_id}" == "#{action_id}"
    answer = {"ability_name" => current_character.action_4_name, "ability_flavor" => current_character.action_4_flavor}
    return answer
  end

  if action_id == "1"
     answer = {"ability_name" => "Attack", "ability_flavor" => ""}
    return answer
 end

 if action_id == "2"
     answer = {"ability_name" => "Guard", "ability_flavor" => ""}
    return answer
 end 

 if action_id == "3"
     answer = {"ability_name" => "Focus", "ability_flavor" => ""}
    return answer
 end
 end  

end
