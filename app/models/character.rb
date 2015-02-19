class Character < ActiveRecord::Base
  attr_protected
  has_one :transformation

  def Character::getIDnum(attackString)
    @idNum = -1
    if(attackString == "Accurate Attack")
      @idNum = 4
    elsif(attackString == "Powerful Attack")
      @idNum = 5
    elsif(attackString== "Reckless Attack")
      @idNum = 6
    elsif(attackString == "Overwhelming Attack")
      @idNum = 7
    elsif(attackString == "Focusing Action")
      @idNum = 8
    elsif(attackString == "Defense Boost")
      @idNum = 9
    elsif(attackString == "Attack Boost")
      @idNum = 10
    elsif(attackString == "Armor Boost")
      @idNum = 11
    elsif(attackString == "Power Boost")
      @idNum = 12
    elsif(attackString == "Poisoning Attack")
      @idNum = 13
    elsif(attackString == "Silencing Attack")
      @idNum = 14
    elsif(attackString == "Confusing Attack")
      @idNum = 15
    elsif(attackString == "Locking Attack")
      @idNum = 16
    elsif(attackString == "Guard Break Attack")
      @idNum = 17
    elsif(attackString == "Armor Break Attack")
      @idNum = 18
    elsif(attackString == "Attack Break Attack")
      @idNum = 19
    elsif(attackString == "Power Break Attack")
      @idNum = 20
    elsif(attackString == "Charge")
      @idNum = 21
    elsif(attackString == "Summon Ally")
      @idNum = 22
    elsif(attackString == "Heal")
      @idNum = 23
    end

    return @idNum

  end

  def Character::get_picture_name(name)
    #['None', 'Bullet', 'Claw', 'Dark Magic', 'Fireball', 'Punch', 'Shield', 'Ice', 
    #'Light Magic', 'Lightning', 'Magic', 'Mana', 'Poison', 'Potion', 'Red Cross', 
    #'Sunlight Burst', 'Sunlight', 'Up Arrow', 'Whirlwind'] 
    if name == 'Bullet'
      return 'Bullet.png'
    elsif name == 'Claw' 
      return 'Claw.png'
    elsif name == 'Slash' 
      return 'Slash.png'
    elsif name == 'Dark Magic' 
      return 'Dark Magic.png'
    elsif name == 'Fireball' 
      return 'Fireball.png'
    elsif name == 'Fist' 
      return 'Fist.png'
    elsif name == 'Shield' 
      return 'Guard.png'
    elsif name == 'Ice' 
      return 'Ice.png'
    elsif name == 'Light Magic' 
      return 'Light Magic.png'
    elsif name == 'Lightning' 
      return 'Lightning.png'
    elsif name == 'Magic' 
      return 'Magic.png'
    elsif name == 'Mana' 
      return 'Mana.png'
    elsif name == 'Poison' 
      return 'Poison.png'
    elsif name == 'Potion' 
      return 'Potion.png'
    elsif name == 'Red Cross' 
      return 'Red Cross.png'
    elsif name == 'Sunlight' 
      return 'Sunlight.png'
    elsif name == 'Sunlight Burst' 
      return 'Sunlight Burst.png'
    elsif name == 'Up Arrow' 
      return 'Up Arrow.png'
    elsif name == 'Whirlwind' 
      return 'Whirlwind.png'
    else
      return nil
    end

  end

  def Character::name_from_picture(name)
    #['None', 'Bullet', 'Claw', 'Dark Magic', 'Fireball', 'Punch', 'Shield', 'Ice', 
    #'Light Magic', 'Lightning', 'Magic', 'Mana', 'Poison', 'Potion', 'Red Cross', 
    #'Sunlight Burst', 'Sunlight', 'Up Arrow', 'Whirlwind'] 
    if name == 'Bullet.png'
      return 'Bullet'
    elsif name == 'Claw.png' 
      return 'Claw'
    elsif name == 'Slash.png' 
      return 'Slash'
    elsif name == 'Dark Magic.png' 
      return 'Dark Magic'
    elsif name == 'Fireball.png' 
      return 'Fireball'
    elsif name == 'Fist.png' 
      return 'Fist'
    elsif name == 'Guard.png' 
      return 'Shield'
    elsif name == 'Ice.png' 
      return 'Ice'
    elsif name == 'Light Magic.png' 
      return 'Light Magic'
    elsif name == 'Lightning.png' 
      return 'Lightning'
    elsif name == 'Magic.png' 
      return 'Magic'
    elsif name == 'Mana.png' 
      return 'Mana'
    elsif name == 'Poison.png' 
      return 'Poison'
    elsif name == 'Potion.png' 
      return 'Potion'
    elsif name == 'Red Cross.png' 
      return 'Red Cross'
    elsif name == 'Sunlight.png' 
      return 'Sunlight'
    elsif name == 'Sunlight Burst.png' 
      return 'Sunlight Burst'
    elsif name == 'Up Arrow.png' 
      return 'Up Arrow'
    elsif name == 'Whirlwind.png' 
      return 'Whirlwind'
    else
      return 'None'
    end

  end


end
