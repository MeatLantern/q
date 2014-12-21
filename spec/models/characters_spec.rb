require 'rails_helper'

RSpec.describe Character, :type => :model do
  describe 'Get ID num' do
    it 'should return 4 for Accurate Attack' do
      return_val = Character::getIDnum('Accurate Attack')
      expect(return_val).to eq 4
    end
    it 'should return 5 for Powerful Attack'do
      return_val = Character::getIDnum('Powerful Attack')
      expect(return_val).to eq(5)
    end
    it 'should return 6 for Reckless Attack' do
      return_val = Character::getIDnum('Reckless Attack')
      expect(return_val).to eq(6)
    end
    it 'should return 7 for Overwhelming Attack' do
      return_val = Character::getIDnum('Overwhelming Attack')
      expect(return_val).to eq(7)
    end
    it 'should return 8 for Focusing Action' do
      return_val = Character::getIDnum('Focusing Attack')
      expect(return_val).to eq(8)
    end
    it 'should return 9 for Defense Boost' do
      return_val = Character::getIDnum('Defense Boost')
      expect(return_val).to eq(9)
    end
    it 'should return 10 for Attack Boost' do
      return_val = Character::getIDnum('Attack Boost')
      expect(return_val).to eq(10)
    end
    it 'should return 11 for Armor Boost' do
      return_val = Character::getIDnum('Armor Boost')
      expect(return_val).to eq(11)
    end
    it 'should return 12 for Power Boost' do
      return_val = Character::getIDnum('Power Boost')
      expect(return_val).to eq(12)
    end
    it 'should return 13 for Poisoning Attack' do
      return_val = Character::getIDnum('Poisoning Attack')
      expect(return_val).to eq(13)
    end
    it 'should return 14 for Silencing Attack' do
      return_val = Character::getIDnum('Silencing Attack')
      expect(return_val).to eq(14)
    end
    it 'should return 15 for Confusing Attack' do
      return_val = Character::getIDnum('Confusing Attack')
      expect(return_val).to eq(15)
    end
    it 'should return 16 for Locking Attack' do
      return_val = Character::getIDnum('Locking Attack')
      expect(return_val).to eq(16)
    end
    it 'should return 17 for Guard Break Attack' do
      return_val = Character::getIDnum('Guard Break Attack')
      expect(return_val).to eq(17)
    end
    it 'should return 18 for Armor Break Attack' do
      return_val = Character::getIDnum('Armor Break Attack')
      expect(return_val).to eq(18)
    end
    it 'should return 19 for Attack Break Attack' do
      return_val = Character::getIDnum('Attack Break Attack')
      expect(return_val).to eq(19)
    end
    it 'should return 20 for Power Break Attack' do
      return_val = Character::getIDnum('Power Break Attack')
      expect(return_val).to eq(20)
    end
    it 'should return 21 for Charge' do
      return_val = Character::getIDnum('Charge')
      expect(return_val).to eq(21)
    end
    it 'should return 22 for Summon Ally' do
      return_val = Character::getIDnum('Summon Ally')
      expect(return_val).to eq(22)
    end
    it 'should return 23 for Heal' do
      return_val = Character::getIDnum('Heal')
      expect(return_val).to eq(23)
    end
  end
end
