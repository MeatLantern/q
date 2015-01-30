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
  			recent_tf = recent_tf + game.player1_last_tf + " <br> <br>" 
  		end
  	end

	if (previous_p2_stage != game.player2_stage)
		if(game.player2_stage == 0)
  			recent_tf = recent_tf + "#{game.player2_character} has turned back to normal!"
  		else
  			recent_tf = recent_tf + game.player2_last_tf
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
      if transformation.is_completed
        tf_tags = tf_tags + "Complete, "
      end
      if transformation.is_full_picture
        tf_tags = tf_tags + "Fully Illustrated, "
      end
      tf_tags.strip!
      tf_tags.chop!
      return tf_tags
  end

  def Transformation::auto_write_tf_text(tag, character_name)
    results = Array.new(10)
    if (tag == "m2f")
      results[0] = "#{character_name} feels their body begin to change. He loses a little bit of his height, and his arms, legs, and shoulders begin to slim down slightly. His hair grows in length a little bit."
      results[1] = "#{character_name} feels their body change even more. His hair has grown even longer, enough that he can now see some of it in between his eyes. His shoulders begin to cave in, and his hips widen slightly, giving him a more feminine appearance. His face softens a little bit. Still, he is clearly a man, albeit a fairly girly one."
      results[2] = "#{character_name} feels their body change further. His hair grows a tad bit longer, and looks a little more feminine in shape, His shoulders cave in much more, as his waist narrows. His hips widen even further. While his manhood remains, it has shrunk down a bit. By now, he could be mistaken for a girl, but still is somewhat manly."
      results[3] = "#{character_name} yells as hips get even wider. His hair has grown even longer than before, and is now in a unmistakably feminine style. His body hair slowly recedes into his body, leaving him almost clean shaven from below the neck. His chest feels oddly sensitive, almost as if it is growing. Meanwhile, his manhood is shrinking more and more ... he likely won't be a man for much longer!"
      results[4] = "#{character_name} feels themselves change. Their manhood is incredibly small, and is only shrinking as they continue to transform. Meanwhile, their chest begins to grow slightly, with the nipples specifically growing as well. Sensitive to the touch, it seems the he might have small breasts. His facial features soften, looking more feminine as well. At this point it'd be hard to tell he was a man from a quick glance, or even a long look."
      results[5] = "#{character_name} changes even further. The completely tiny breasts begin to grow a bit larger, although they're still quite small. His hair grows longer, now reaching the middle of his back. His face softens immensely, becoming delicate and more womanly. Even his eyes seem far more feminine than before."
      results[6] = "#{character_name} continues to change. Their manhood is slowly being sucked completely into their body...if the changes go much further, he'll truly be a woman. Already his body is completely unrecognizable as man. He has a petite, feminine figure with soft, slender legs and enchantingly beautiful long hair. He still possesses his manly clothing, although his red T-shirt is beginning to brighten, changing a little bit closer to pink."
      results[7] = "#{character_name} changes once again. His manhood has now completely disappeared, replaced with a womanly slit. He is now truly a she. She possesses a very girly and feminine body. However, her changes aren't over yet. Her clothing is still changing. Her pants are slowly combining into one giant pant leg, and changing color as well. Her red shirt is becoming more pink by the second."
      results[8] = "While #{character_name} is now fully a woman physically, his clothes are now adjusting to his new girly form. His pants had already fused into one long pant leg, but now it is shortening, forming a frilly skirt. Its color is brightening, changing closer to pink. Her hair changes styles, becoming incredibly feminine."
      results[9] = "The transformation is now complete. Nothing manly remains of #{character_name}. Her clothes have changed further, becoming an adorable and incredibly feminine pink dress. She now wears beautiful make-up, and looks about ready to visit a royal ball. She is completely a girl now, and has lost the match!"
    elsif (tag == "f2m")
      results[0] = "#{character_name} feels a wave of magic overcome her. Her shoulders get a tiny bit wider, as her hips start to narrow slightly. She grows a little larger in height, only about an inch. Still, she's clearly female, only a tiny bit manlier than she was before."
      results[1] = "#{character_name} begins to change once again. Her hair becomes a little bit shorter, as her shoulders once again expand. Her face looks a little bit less delicate, as her waist begins to widen. She's still clearly a woman, but with each change she's looking more and more manly with each moment."
      results[2] = "#{character_name} changes once again. Her hair becomes much shorter, though it still retains a feminine style. Oddly enough, an Adam's Apple appears near her throat, though her neck still appears thin and feminine. Meanwhile, her chest expands and her breasts begin to very slowly deflate, almost like a balloon."
      results[3] = "#{character_name} changes further. Her breasts continue to grow smaller, while her waist widens. She's losing her hourglass figure, as her shoulders grow a little bit larger. Her face begins to get thicker, looking less delicate with each passing moment. Her biceps have grown as well."
      results[4] = "#{character_name} begins to feel a small pressure near her womanhood. It still feels normal but...something's a little strange. Her breasts continue to shrink, while her hips narrow. Her hair is getting shorter as well. From first glance, she'd be very androgynous. Few could tell her gender exactly, though she is still female."
      results[5] = "#{character_name}'s chest continues to bulk up, while her hips narrow once again. By now, with her figure most might assume she's a man, yet her very tiny breasts and womanhood remain. The pressure continues to increase though, almost like something might want to burst out. Her hair is now quite short, and cut in a slightly more masculine style."
      results[6] = "#{character_name} feels the pressure intensify in her womanhood. In mere moments something might burst out, and with her new fully masculine face she is pretty certain as to what it will be. Her arms begin to bulk up, as do her legs. She no longer looks slender and feminine...in fact, she looks pretty manly."
      results[7] = "For #{character_name}, the biggest change has finally come. Her breasts finally meld into her skin, becoming manly pecs. Out of her vagina a manhood has grown. With her masculine figure and hair, she is clearly a man now. However, her clothes remain rather feminine."
      results[8] = "#{character_name} may be a man, but his clothing is still rather feminine, with a pink low cut dress, pink panties and a pink bra. The bra simply disappears, while his panties slowly morph into red boxers. His pink dress separates in two, forming a pink shirt and a pink skirt. Both of their colors are darkening. If he loses any more, his transformation will be complete!"
      results[9] = "#{character_name} is finally done transforming. His pink shirt has become red, while his pink skirt has become simple kakhi shorts. He has short, well-groomed hair styled in a masculine fashion, and with the new clothes looks completely normal. He is now a man forever more!"
    elsif (tag == "age_reg")
      results[0] = "#{character_name} feels her body begin to change. She begins to lose a little bit of height, while some of the small wrinkles on her body begin to disappear. However, she still appears to be mostly the same, only a tad shorter. While she used to be about 35, she looks a little closer to 33 now."
      results[1] = "#{character_name} feels another change come in. She loses even more height this time, about 3 inches or so. As she loses her height, some of her memories seem to just...disappear. In fact, it's like the last few years of her life never happened! Still, she's close to the same age at least..."
      results[2] = "#{character_name} continues to lose some of their age. Once again she loses some height, a few inches or so. However, by now some other traits are changing. Her breasts are beginning to shrink. Her face appears a little soft, having lost some of the challenges of her life. She appears to be about 25."
      results[3] = "#{character_name} She loses another inch or so of height. Meanwhile, she seems more...innocent than before. Her skin is clearer, she has a larger smile...it's as if she has forgotten some of the difficulties of her life. She appears slightly more fit as well, and looks to be about 20 now."
      results[4] = "#{character_name} no longer looks like she would be going to college...instead she appears to be in high school. Unlike before, she now wears her hair in a ponytail. She has lost a good bit of height, and embarrassingly enough a bit of breast size as well. Meanwhile, her mind seems to be changing...she's acting far more immature than before."
      results[5] = "#{character_name} she continues to lose height at a rapid rate. Her breasts have become much smaller now. She seems oddly more cheerful as well. She no longer looks like she should be in high school, she looks about 15 years old."
      results[6] = "#{character_name} loses even more of her age. As she gets younger and younger, her height is almost exponentially decreasing. She seems far more distracted than before, and it seems more like she wants to play around than win this fight. At only 11 years old, she's very energetic."
      results[7] = "#{character_name} is losing more age by the second. She appears to be only 8 years old, and to be frank is pretty adorable. She's far shorter, lacks any real secondary sexual characteristics, and seems incredibly distracted."
      results[8] = "#{character_name} is only about 6 years old now. Without any real maturity, she seems to be somewhat selfish, but is very kind at heart. She loves princesses and rainbows and unicorns above all else...and if she loses any more, she'll be stuck as a 4 year old!"
      results[9] = "#The transformation of {character_name} is complete. She is now about 4 years old, unable to defend herself and still incredibly immature, though she is very curious about the world. She has lost the match, and will have to grow up again before she could fight anyone."
    elsif (tag == "furry")
      results[0] = "#{character_name} begins to change. Her hand begins to itch for some reason, and when he looks down it appears a small amount of hair is growing on it! Not only that, but fur seems to be growing out on his legs as well. It's the same color as a [INSERT ANIMAL HAIR COLOR HERE], oddly enough..."
      results[1] = "For #{character_name}, the hair on his hands and legs is only growing. It seems to be creeping up his forearm, almost like an infection. His ears begin to feel strange, almost like they're hot, while the area around his back feels strange as well. Actually, it doesn't really look like hair, it looks more like the fur of a [INSERT ANIMAL HERE]!"
      results[2] = "#{character_name} changes further. The fur continues to grow up his arms and legs. Not only that, but he nearly trips as his feet begin to morph. They curl in pain as they slowly change into paws, similar to a [INSERT ANIMAL HERE!]. his shoes naturally break during the transformation, though thankfully he can still stand normally."
      results[3] = "#{character_name} transforms even more. As the fur continues to creep up his body, he can't help but groan for a moment. His body feels much warmer than before, and he almost involuntarily takes his shirt off. He can't help but gasp as he sees some of his chest is covered in fur, just like a [INSERT ANIMAL HERE!]"
      results[4] = "#{character_name} feels incredibly strange as he changes more. He sees a large flash, and when he can finally see again his eyes have changed to that of a [INSERT ANIMAL HERE!]. His ears that were burning earlier burn far more this time, and meld into the side of his head. After a shrot moment of horror, his ears return to him. However, they are now at the top of his head, just like a [INSERT ANIMAL HERE!]. Despite this, he can hear perfectly fine."
      results[5] = "Much of #{character_name}'s body is now covered in fur, just like a [INSERT ANIMAL HERE!] . Not only that, but the pain from earlier is now focused into has hands, which become more paw-like. They still retain full human use, fortunately enough. #{character_name} is looking more and more like a [INSERT ANIMAL HERE] as he transforms..."
      results[6] = "#{character_name} continues to transform. His nose changes shape, now looking more like the nose of a [INSERT ANMIAL HERE]. It looks kind of bizarre to have the animal nose on a human face. Meanwhile, a tail shoots out of his back, just like the tail of a [INSERT ANIMAL HERE]. Soon enough, #{character_name} will be fully transformed..."
      results[7] = "#{character_name} changes even further. By now, almost his entire body is completely covered in the fur of a [INSERT ANIMAL HERE]. He looks like a fusion of man and beast, except for the head...but even that's beginning to change. It is starting to elongate...soon enough, it might form into a muzzle, just like a [INSERT ANIMAL HERE]"
      results[8] = "#{character_name}'s transformation is almost complete. His face has formed a muzzle, just like a [INSERT ANIMAL HERE]. However, there are still some spots of human skin remaining. If he loses a little more, he will completely turn into a half-man, half-beast creature."
      results[9] = "#{character_name} has completed his transformation. He has completely transformed into a fusion of man and beast, with a [INSERT ANIMAL HERE]-like muzzle, as well as fur covering his whole body. He has been defeated!"
    elsif (tag == "inanimate")
      results[0] = "#{character_name} begins to change slightly. His feet start to feel a little bit stiff, though he can still move them fairly easily. Not only are they stiff, but they feel a bit numb as well...regardless, he's still at full fighting capacity. If he could see though, he'd notice his feet are now covered in small speckles of marble..."
      results[1] = "#{character_name} can feel his feet stiffen up far more now. They can barely move, almost as if they're completely stuck in place. Not only that, but his feet feel far heavier than before. Oddly enough he can still fight well enough. In panic, he pulls off his shoes, revealing that his feet are now made of white marble...and that the white marble is slowly crawling his ankles."
      results[2] = "#{character_name} continues his transformation. The white marble continues to crawl up his legs, now going almost up to his shins. He tries to shake it off, but it's not simply growing on the skin of his leg...his whole leg is changing. It's becoming solid marble, which makes it harder to move every second. If he loses this fight, he'll likely become just a simple statue..."
      results[3] = "#{character_name} transforms even further. By now, his legs are almost completely marble. He can barely move them. They begin to shift in place, forcing him to stand at attention, like a soldier saluting his superior. He frantically tries to break free from the position, but is unable to."
      results[4] = "#{character_name} screams for a moment as more of himself turns into marble. His legs are completely stone now, and the marble has managed to reach just above his waist. He can't move his legs in the slightest. Scarily enough, it doesn't feel painful...in fact, he can't feel it at all. He can't afford to lose more now..."
      results[5] = "#{character_name} can't resist the transformation anymore. By now, everything up to his belly button is pure marble. Each movement is harder and harder to make. The rest of his body feels almost intensely hot...or more accurately, his marble body is cold. It's so cold he can't really feel it."
      results[6] = "#{character_name} transformation continues once again. The marble has managed to grow much further, now reaching up to his shoulders. His entire body is almost unable to move, still standing at attention like a loyal soldier. His transformation is getting eerily close to completion..."
      results[7] = "#{character_name} transformation moves even further. His arms are now fully marble, locked into a salute...it seems his opponent wanted him to be forever saluting his superior opponent. All that remains is his head and neck, still normal human flesh. But for how long?"
      results[8] = "#{character_name} is almost completely transformed. His neck and the lower half of his face is now transformed into marble. He's unable to speak, his lips now forever stuck in place. He can still look around, horrified that his whole body has become this white marble statue. In mere moments he may fully become a statue."
      results[9] = "#{character_name} has now completely transformed. His whole body is now completely made of immovable white marble. He appears to be a statue saluting his opponent, made in unbelievable detail. His mind remains, trapped in a statue that will never be able to move. #{character_name} has lost, and will now serve as a trophy to his opponent's victory."
    end 

    return results

  end

  def Transformation::auto_write_char_text(tag, character_name)
    results = []
    if (tag == "m2f")
      results[0] = "#{character_name} is a fairly masculine man."
      results[1] = "#{character_name} is a fairly girly man."
      results[2] = "#{character_name} is androgynous, between man and woman."
      results[3] = "#{character_name} is a fairly feminine woman."
    elsif (tag == "f2m")
      results[0] = "#{character_name} is a fairly feminine woman."
      results[1] = "#{character_name} is a fairly manly woman."
      results[2] = "#{character_name} is androgynous, between man and woman."
      results[3] = "#{character_name} is a fairly masculine man."
    elsif (tag == "age_reg")
      results[0] = "#{character_name} is a middle aged woman."
      results[1] = "#{character_name} is a young woman."
      results[2] = "#{character_name} is young girl."
      results[3] = "#{character_name} is barely a toddler."
    elsif (tag == "furry")
      results[0] = "#{character_name} is a normal human man."
      results[1] = "#{character_name} is a human man, with some animal parts."
      results[2] = "#{character_name} is barely human, with many animal parts."
      results[3] = "#{character_name} is more similar to an anthro creature than a human."
    elsif (tag == "inanimate")
      results[0] = "#{character_name} is a normal human being."
      results[1] = "#{character_name} is a human, though part of him is stone."
      results[2] = "#{character_name} is more than partially turned into stone."
      results[3] = "#{character_name} is no longer a human, now simply a statue."
    end
    return results
  end

  def Transformation::initial_button_preferences
    button_hash = {}
    button_hash['is_M2F'] = true
    button_hash['is_F2M'] = true
    button_hash['is_race_change'] = true
    button_hash['is_age_reg'] = true
    button_hash['is_age_pro'] = true
    button_hash['is_furry'] = true
    button_hash['is_animal'] = true
    button_hash['is_futa'] = true
    button_hash['is_mind'] = true
    button_hash['is_bdsm'] = true
    button_hash['is_pregnant'] = true
    button_hash['is_inanimate'] = true
    button_hash['is_growth'] = true
    button_hash['is_shrink'] = true
    button_hash['is_weight_gain'] = true
    button_hash['is_fantasy'] = true
    button_hash['is_bizarre'] = true
    button_hash['is_robot'] = true
    button_hash['is_monster_girl'] = true
    button_hash['is_completed'] = true
    button_hash['is_full_picture'] = true
    session["button_pref"] = button_hash

  end

  def Transformation::button_hash_editor(preferences)
    #binding.pry
    button_hash = session["button_pref"]
    preferences.each do |key, value|
      if value == "0"
          button_hash[key] = false
      elsif value == "1"
          button_hash[key] = true
      end
    end
    session["button_pref"] = button_hash
  end

end
