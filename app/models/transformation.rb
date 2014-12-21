class Transformation < ActiveRecord::Base
  belongs_to :character
  attr_protected

  def Transformation::transformation_handler(game)
  	character1 = Character.find_by_name(game.player1_character)
  	character2 = Character.find_by_name(game.player2_character)

  	recent_tf = ""

  	previous_p1_stage = game.player1_stage
  	previous_p2_stage = game.player2_stage

  	#Player 1 Stuff
  	max_hp = character1.max_hp
  	percentage_hp = game.p1_hp.fdiv(max_hp)
  	if percentage_hp <= 0
  		game.player1_stage = 10
  		game.player1_last_tf = character1.transformation.stage10_tf_description
  		game.player1_description = character1.transformation.stage10_character_description
  		game.player1_picture = character1.transformation.stage10_tf_picture
  	elsif percentage_hp <= 0.1
  		game.player1_stage = 9
  		game.player1_last_tf = character1.transformation.stage9_tf_description
  		game.player1_description = character1.transformation.stage9_character_description
  		game.player1_picture = character1.transformation.stage9_tf_picture
  	elsif percentage_hp <= 0.2
  		game.player1_stage = 8
  		game.player1_last_tf = character1.transformation.stage8_tf_description
  		game.player1_description = character1.transformation.stage8_character_description
  		game.player1_picture = character1.transformation.stage8_tf_picture
  	elsif percentage_hp <= 0.3
  		game.player1_stage = 7
  		game.player1_last_tf = character1.transformation.stage7_tf_description
  		game.player1_description = character1.transformation.stage7_character_description
  		game.player1_picture = character1.transformation.stage7_tf_picture
  	elsif percentage_hp <= 0.4
  		game.player1_stage = 6
  		game.player1_last_tf = character1.transformation.stage6_tf_description
  		game.player1_description = character1.transformation.stage6_character_description
  		game.player1_picture = character1.transformation.stage6_tf_picture
  	elsif percentage_hp <= 0.5
  		game.player1_stage = 5
  		game.player1_last_tf = character1.transformation.stage5_tf_description
  		game.player1_description = character1.transformation.stage5_character_description
  		game.player1_picture = character1.transformation.stage5_tf_picture
  	elsif percentage_hp <= 0.6
  		game.player1_stage = 4
  		game.player1_last_tf = character1.transformation.stage4_tf_description
  		game.player1_description = character1.transformation.stage4_character_description
  		game.player1_picture = character1.transformation.stage4_tf_picture  		
  	elsif percentage_hp <= 0.7
  		game.player1_stage = 3
  		game.player1_last_tf = character1.transformation.stage3_tf_description
  		game.player1_description = character1.transformation.stage3_character_description
  		game.player1_picture = character1.transformation.stage3_tf_picture  	
  	elsif percentage_hp <= 0.8
  		game.player1_stage = 2
  		game.player1_last_tf = character1.transformation.stage2_tf_description
  		game.player1_description = character1.transformation.stage2_character_description
  		game.player1_picture = character1.transformation.stage2_tf_picture  
  	elsif percentage_hp <= 0.9
  		game.player1_stage = 1
  		game.player1_last_tf = character1.transformation.stage1_tf_description
  		game.player1_description = character1.transformation.stage1_character_description
  		game.player1_picture = character1.transformation.stage1_tf_picture
  	else
  		game.player1_stage = 0
  		game.player1_last_tf = "None"
  		game.player1_description = character1.description
  		game.player1_picture = character1.main_image
  	end

  	#Player 2 Stuff
  	max_hp = character2.max_hp
  	percentage_hp = game.p2_hp.fdiv(max_hp)
  	if percentage_hp <= 0
  		game.player2_stage = 10
  		game.player2_last_tf = character2.transformation.stage10_tf_description
  		game.player2_description = character2.transformation.stage10_character_description
  		game.player2_picture = character2.transformation.stage10_tf_picture
  	elsif percentage_hp <= 0.1
  		game.player2_stage = 9
  		game.player2_last_tf = character2.transformation.stage9_tf_description
  		game.player2_description = character2.transformation.stage9_character_description
  		game.player2_picture = character2.transformation.stage9_tf_picture
  	elsif percentage_hp <= 0.2
  		game.player2_stage = 8
  		game.player2_last_tf = character2.transformation.stage8_tf_description
  		game.player2_description = character2.transformation.stage8_character_description
  		game.player2_picture = character2.transformation.stage8_tf_picture
  	elsif percentage_hp <= 0.3
  		game.player2_stage = 7
  		game.player2_last_tf = character2.transformation.stage7_tf_description
  		game.player2_description = character2.transformation.stage7_character_description
  		game.player2_picture = character2.transformation.stage7_tf_picture
  	elsif percentage_hp <= 0.4
  		game.player2_stage = 6
  		game.player2_last_tf = character2.transformation.stage6_tf_description
  		game.player2_description = character2.transformation.stage6_character_description
  		game.player2_picture = character2.transformation.stage6_tf_picture
  	elsif percentage_hp <= 0.5
  		game.player2_stage = 5
  		game.player2_last_tf = character2.transformation.stage5_tf_description
  		game.player2_description = character2.transformation.stage5_character_description
  		game.player2_picture = character2.transformation.stage5_tf_picture
  	elsif percentage_hp <= 0.6
  		game.player2_stage = 4
  		game.player2_last_tf = character2.transformation.stage4_tf_description
  		game.player2_description = character2.transformation.stage4_character_description
  		game.player2_picture = character2.transformation.stage4_tf_picture  		
  	elsif percentage_hp <= 0.7
  		game.player2_stage = 3
  		game.player2_last_tf = character2.transformation.stage3_tf_description
  		game.player2_description = character2.transformation.stage3_character_description
  		game.player2_picture = character2.transformation.stage3_tf_picture  	
  	elsif percentage_hp <= 0.8
  		game.player2_stage = 2
  		game.player2_last_tf = character2.transformation.stage2_tf_description
  		game.player2_description = character2.transformation.stage2_character_description
  		game.player2_picture = character2.transformation.stage2_tf_picture  
  	elsif percentage_hp <= 0.9
  		game.player2_stage = 1
  		game.player2_last_tf = character2.transformation.stage1_tf_description
  		game.player2_description = character2.transformation.stage1_character_description
  		game.player2_picture = character2.transformation.stage1_tf_picture
  	else
  		game.player2_stage = 0
  		game.player2_last_tf = "None"
  		game.player2_description = character2.description
  		game.player2_picture = character2.main_image
  	end
  	#Check for Recent Transformations
  	if (previous_p1_stage != game.player1_stage)
  		if(game.player1_stage == 0)
  			recent_tf = recent_tf + "#{game.player1_character} has turned back to normal!"
  		else
  			recent_tf = recent_tf + game.player1_last_tf + " "
  		end
  	end

	if (previous_p2_stage != game.player2_stage)
		if(game.player2_stage == 0)
  			recent_tf = recent_tf + "#{game.player2_character} has turned back to normal!"
  		else
  			recent_tf = recent_tf + game.player2_last_tf + " "
  		end 
  	end  	

  	return recent_tf
  end

  def Transformation::get_tag_list(transformation)
      tf_tags = ""
      #binding.pry
      if transformation.is_adult
        tf_tags = tf_tags + "Adult, "
      end
      if transformation.is_M2F
        tf_tags = tf_tags + "Male to Female, "
      end
      if transformation.is_F2M
        tf_tags = tf_tags + "Female to Male, "
      end
      if transformation.is_race_change
        tf_tags = tf_tags + "Race Change, "
      end
      if transformation.is_age_reg
        tf_tags = tf_tags + "Age Regression, "
      end
      if transformation.is_age_pro
        tf_tags = tf_tags + "Age Progression, "
      end
      if transformation.is_furry
        tf_tags = tf_tags + "Furry, "
      end
      if transformation.is_animal
        tf_tags = tf_tags + "Animal, "
      end
      if transformation.is_futa
        tf_tags = tf_tags + "Futanari/Hermaphrodite, "
      end
      if transformation.is_mind
        tf_tags = tf_tags + "Mental Change, "
      end
      if transformation.is_bdsm
        tf_tags = tf_tags + "BDSM, "
      end
      if transformation.is_pregnant
        tf_tags = tf_tags + "Pregnant, "
      end
      if transformation.is_inanimate
        tf_tags = tf_tags + "Inanimate, "
      end
      if transformation.is_growth
        tf_tags = tf_tags + "Growth/Expansion, "
      end
      if transformation.is_shrink
        tf_tags = tf_tags + "Shrinking, "
      end
      if transformation.is_weight_gain
        tf_tags = tf_tags + "Weight Gain, "
      end
      if transformation.is_fantasy
        tf_tags = tf_tags + "Fantasy/Mythical, "
      end
      if transformation.is_robot
        tf_tags = tf_tags + "Robot/Cyborg/Sci Fi, "
      end
      if transformation.is_monster_girl
        tf_tags = tf_tags + "Monster Girl, "
      end
      if transformation.is_bimbo
        tf_tags = tf_tags + "Bimbo, "
      end
      if transformation.is_bizarre
        tf_tags = tf_tags + "Bizarre, "
      end
      tf_tags.strip!
      tf_tags.chop!
      return tf_tags
  end
end
