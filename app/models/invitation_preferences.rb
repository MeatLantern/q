class InvitationPreferences < ActiveRecord::Base
  belongs_to :game_invitation
  attr_protected

  def InvitationPreferences::get_tag_list(transformation)
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

  def InvitationPreferences::get_rules_hash(pref)
    rules_hash = {}
    rules_hash[:is_adult] = pref.is_adult
    rules_hash[:is_M2F] = pref.is_M2F
    rules_hash[:is_F2M] = pref.is_F2M
    rules_hash[:is_race_change] = pref.is_race_change
    rules_hash[:is_age_reg] = pref.is_age_reg
    rules_hash[:is_age_pro] = pref.is_age_pro
    rules_hash[:is_furry] = pref.is_furry
    rules_hash[:is_animal] = pref.is_animal
    rules_hash[:is_futa] = pref.is_futa
    rules_hash[:is_mind] = pref.is_mind
    rules_hash[:is_bdsm] = pref.is_bdsm
    rules_hash[:is_pregnant] = pref.is_pregnant
    rules_hash[:is_inanimate] = pref.is_inanimate
    rules_hash[:is_growth] = pref.is_growth
    rules_hash[:is_shrink] = pref.is_shrink
    rules_hash[:is_weight_gain] = pref.is_weight_gain
    rules_hash[:is_fantasy] = pref.is_fantasy
    rules_hash[:is_bimbo] = pref.is_bimbo
    rules_hash[:is_robot] = pref.is_robot
    rules_hash[:is_monster_girl] = pref.is_monster_girl
    rules_hash[:is_bizarre] = pref.is_bizarre
    return rules_hash
  end

  def InvitationPreferences::get_transformation_hash(pref)

    rules_hash = {}

    if(pref.is_adult)
      rules_hash[:is_adult] = "1"
    else
      rules_hash[:is_adult] = "0"
    end
    
    if(pref.is_M2F)
      rules_hash[:is_M2F] = "1"
    else
      rules_hash[:is_M2F] = "0"
    end

    if(pref.is_F2M)
      rules_hash[:is_F2M] = "1"
    else
      rules_hash[:is_F2M] = "0"
    end

    if(pref.is_race_change)
      rules_hash[:is_race_change] = "1"
    else
      rules_hash[:is_race_change] = "0"
    end

    if(pref.is_age_reg)
      rules_hash[:is_age_reg] = "1"
    else
      rules_hash[:is_age_reg] = "0"
    end

    if(pref.is_age_pro)
      rules_hash[:is_age_pro] = "1"
    else
      rules_hash[:is_age_pro] = "0"
    end

    if(pref.is_furry)
      rules_hash[:is_furry] = "1"
    else
      rules_hash[:is_furry] = "0"
    end

    if(pref.is_animal)
      rules_hash[:is_animal] = "1"
    else
      rules_hash[:is_animal] = "0"
    end

    if(pref.is_futa)
      rules_hash[:is_futa] = "1"
    else
      rules_hash[:is_futa] = "0"
    end

    if(pref.is_mind)
      rules_hash[:is_mind] = "1"
    else
      rules_hash[:is_mind] = "0"
    end

    if(pref.is_bdsm)
      rules_hash[:is_bdsm] = "1"
    else
      rules_hash[:is_bdsm] = "0"
    end

    if(pref.is_pregnant)
      rules_hash[:is_pregnant] = "1"
    else
      rules_hash[:is_pregnant] = "0"
    end  

    if(pref.is_inanimate)
      rules_hash[:is_inanimate] = "1"
    else
      rules_hash[:is_inanimate] = "0"
    end 

    if(pref.is_growth)
      rules_hash[:is_growth] = "1"
    else
      rules_hash[:is_growth] = "0"
    end

    if(pref.is_shrink)
      rules_hash[:is_shrink] = "1"
    else
      rules_hash[:is_shrink] = "0"
    end

    if(pref.is_weight_gain)
      rules_hash[:is_weight_gain] = "1"
    else
      rules_hash[:is_weight_gain] = "0"
    end

    if(pref.is_fantasy)
      rules_hash[:is_fantasy] = "1"
    else
      rules_hash[:is_fantasy] = "0"
    end

    if(pref.is_bimbo)
      rules_hash[:is_bimbo] = "1"
    else
      rules_hash[:is_bimbo] = "0"
    end

    if(pref.is_robot)
      rules_hash[:is_robot] = "1"
    else
      rules_hash[:is_robot] = "0"
    end

    if(pref.is_monster_girl)
      rules_hash[:is_monster_girl] = "1"
    else
      rules_hash[:is_monster_girl] = "0"
    end

    if(pref.is_bizarre)
      rules_hash[:is_bizarre] = "1"
    else
      rules_hash[:is_bizarre] = "0"
    end

    return rules_hash

  end

end
