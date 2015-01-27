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
end
