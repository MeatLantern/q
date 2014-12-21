require 'rails_helper'

RSpec.describe Game, :type => :model do
 
 describe 'basic attacks' do

 		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end
		
		it 'should return a string for player 1 turn' do
			
			@game.current_turn = 1

			results = Game::basic_attack(5,5,5,5,1,@game)

			x = results.nil?

			expect(x).to eq false 
		end

		it 'should return a string for player 2 turn' do
			
			@game.current_turn = 2

			results = Game::basic_attack(5,5,5,5,2,@game)

			x = results.nil?

			expect(x).to eq false 
		end

		it 'should return a string for player 1 turn guarding' do
			@game.current_turn = 1
			@game.p1_guard = "t"

			results = Game::basic_attack(5,5,5,5,1,@game)

			x = results.nil?

			expect(x).to eq false 
		end

		it 'should return a string for player 2 turn guarding' do
			
			@game.current_turn = 2
			@game.p1_guard = "f"
			@game.p2_guard = "t"

			results = Game::basic_attack(5,5,5,5,2,@game)

			x = results.nil?

			expect(x).to eq false 
		end


	end

	describe 'taking a turn as player 1 with no mana' do

		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end

 		before(:each) do
 			@game.p1_mp = 0
 			@game.current_turn = 1
			@game.p1_guard = "f"
			@game.p2_guard = "f"
 		end

		it 'should take an attack action with action_id = 1 for player 1' do

			results = Game::take_action("1", @game)
			x = results.include? "Attack"

			expect(x).to eq true
		end

		it 'should take a guard action with action_id = 2 for player 1' do

			results = Game::take_action("2", @game)
			x = results.include? "Guard"

			expect(x).to eq true
		end

		it 'should take a focus action with action_id = 3 for player 1' do

			results = Game::take_action("3", @game)
			x = results.include? "ocus"

			expect(x).to eq true
		end
		

		it 'should take an accurate attack action with action_id = 4 for player 1' do

			results = Game::take_action("4", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an powerful attack action with action_id = 5 for player 1' do

			results = Game::take_action("5", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an accurate attack action with action_id = 6 for player 1' do
			
			results = Game::take_action("6", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an accurate attack action with action_id = 7 for player 1' do

			results = Game::take_action("7", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Focusing action with action_id = 8 for player 1' do
			
			results = Game::take_action("8", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Defense Boost action with action_id = 9 for player 1' do

			results = Game::take_action("9", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Attack Boost action with action_id = 10 for player 1' do

			results = Game::take_action("10", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Armor Boost action with action_id = 11 for player 1' do

			results = Game::take_action("11", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Power Boost action with action_id = 12 for player 1' do
			
			results = Game::take_action("12", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Poisoning Attack action with action_id = 13 for player 1' do

			results = Game::take_action("13", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Silencing Attack action with action_id = 14 for player 1' do

			results = Game::take_action("14", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Confusing Attack action with action_id = 15 for player 1' do
		
			results = Game::take_action("15", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Locking Attack action with action_id = 16 for player 1' do

			results = Game::take_action("16", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Defense Break action with action_id = 17 for player 1' do
			
			results = Game::take_action("17", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Armor Break action with action_id = 18 for player 1' do
			
			results = Game::take_action("18", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Attack Break action with action_id = 19 for player 1' do
			
			results = Game::take_action("19", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Power Break action with action_id = 20 for player 1' do
			
			results = Game::take_action("20", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Charge action with action_id = 21 for player 1' do
			
			results = Game::take_action("21", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end		

		it 'should take an Summon action with action_id = 22 for player 1' do
			
			results = Game::take_action("22", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end	

		it 'should take an Heal action with action_id = 23 for player 1' do
			
			results = Game::take_action("22", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end		

	end

	describe 'taking a turn as player 1' do

		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end

 		before(:each) do
 			@game.p1_mp = 100
 			@game.current_turn = 1
			@game.p1_guard = "f"
			@game.p2_guard = "f"
 		end

		it 'should take an attack action with action_id = 1 for player 1' do

			results = Game::take_action("1", @game)
			x = results.include? "Attack"

			expect(x).to eq true
		end

		it 'should take a guard action with action_id = 2 for player 1' do

			results = Game::take_action("2", @game)
			x = results.include? "Guard"

			expect(x).to eq true
		end

		it 'should take a focus action with action_id = 3 for player 1' do

			results = Game::take_action("3", @game)
			x = results.include? "ocus"

			expect(x).to eq true
		end
		

		it 'should take an accurate attack action with action_id = 4 for player 1' do

			results = Game::take_action("4", @game)
			x = results.include? "ccurate"

			expect(x).to eq true
		end

		it 'should take an powerful attack action with action_id = 5 for player 1' do

			results = Game::take_action("5", @game)
			x = results.include? "o"

			expect(x).to eq true
		end

		it 'should take an accurate attack action with action_id = 6 for player 1' do
			
			results = Game::take_action("6", @game)
			x = results.include? "eckless"

			expect(x).to eq true
		end

		it 'should take an accurate attack action with action_id = 7 for player 1' do

			results = Game::take_action("7", @game)
			x = results.include? "elm"

			expect(x).to eq true
		end

		it 'should take an Focusing action with action_id = 8 for player 1' do
			
			results = Game::take_action("8", @game)
			x = results.include? "e"

			expect(x).to eq true
		end

		it 'should take an Defense Boost action with action_id = 9 for player 1' do

			results = Game::take_action("9", @game)
			x = results.include? "fense"

			expect(x).to eq true
		end

		it 'should take an Attack Boost action with action_id = 10 for player 1' do

			results = Game::take_action("10", @game)
			x = results.include? "ack"

			expect(x).to eq true
		end

		it 'should take an Armor Boost action with action_id = 11 for player 1' do

			results = Game::take_action("11", @game)
			x = results.include? "mor"

			expect(x).to eq true
		end

		it 'should take an Power Boost action with action_id = 12 for player 1' do
			
			results = Game::take_action("12", @game)
			x = results.include? "e"

			expect(x).to eq true
		end

		it 'should take an Poisoning Attack action with action_id = 13 for player 1' do

			results = Game::take_action("13", @game)
			x = results.include? "oison"

			expect(x).to eq true
		end

		it 'should take an Silencing Attack action with action_id = 14 for player 1' do

			results = Game::take_action("14", @game)
			x = results.include? "e"

			expect(x).to eq true
		end

		it 'should take an Confusing Attack action with action_id = 15 for player 1' do
		
			results = Game::take_action("15", @game)
			x = results.include? "fus"

			expect(x).to eq true
		end

		it 'should take an Locking Attack action with action_id = 16 for player 1' do

			results = Game::take_action("16", @game)
			x = results.include? "ock"

			expect(x).to eq true
		end

		it 'should take an Defense Break action with action_id = 17 for player 1' do
			
			results = Game::take_action("17", @game)
			x = results.include? "ense"

			expect(x).to eq true
		end

		it 'should take an Armor Break action with action_id = 18 for player 1' do
			
			results = Game::take_action("18", @game)
			x = results.include? "mor"

			expect(x).to eq true
		end

		it 'should take an Attack Break action with action_id = 19 for player 1' do
			
			results = Game::take_action("19", @game)
			x = results.include? "ack"

			expect(x).to eq true
		end

		it 'should take an Power Break action with action_id = 20 for player 1' do
			
			results = Game::take_action("20", @game)
			x = results.include? "ow"

			expect(x).to eq true
		end

		it 'should take an Charge action with action_id = 21 for player 1' do
			
			results = Game::take_action("21", @game)
			x = results.include? "arge"

			expect(x).to eq true
		end		

		it 'should take an Summon action with action_id = 22 for player 1' do
			
			results = Game::take_action("22", @game)
			x = results.include? "ummon"

			expect(x).to eq true
		end	

		it 'should take an Heal action with action_id = 23 for player 1' do
			
			results = Game::take_action("22", @game)
			x = results.include? "eal"

			expect(x).to eq true
		end		

	end

	describe 'taking a turn as player 2' do

		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end

 		before(:each) do
 			@game.p1_mp = 100
 			@game.current_turn = 2
			@game.p1_guard = "f"
			@game.p2_guard = "f"
 		end

		it 'should take an attack action with action_id = 1 for player 2' do

			results = Game::take_action("1", @game)
			x = results.include? "Attack"

			expect(x).to eq true
		end

		it 'should take a guard action with action_id = 2 for player 2' do

			results = Game::take_action("2", @game)
			x = results.include? "Guard"

			expect(x).to eq true
		end

		it 'should take a focus action with action_id = 3 for player 2' do

			results = Game::take_action("3", @game)
			x = results.include? "ocus"

			expect(x).to eq true
		end
		

		it 'should take an accurate attack action with action_id = 4 for player 2' do

			results = Game::take_action("4", @game)
			x = results.include? "ccurate"

			expect(x).to eq true
		end

		it 'should take an powerful attack action with action_id = 5 for player 2' do

			results = Game::take_action("5", @game)
			x = results.include? "o"

			expect(x).to eq true
		end

		it 'should take an accurate attack action with action_id = 6 for player 2' do
			
			results = Game::take_action("6", @game)
			x = results.include? "eckless"

			expect(x).to eq true
		end

		it 'should take an accurate attack action with action_id = 7 for player 2' do

			results = Game::take_action("7", @game)
			x = results.include? "elm"

			expect(x).to eq true
		end

		it 'should take an Focusing action with action_id = 8 for player 2' do
			
			results = Game::take_action("8", @game)
			x = results.include? "e"

			expect(x).to eq true
		end

		it 'should take an Defense Boost action with action_id = 9 for player 2' do

			results = Game::take_action("9", @game)
			x = results.include? "fense"

			expect(x).to eq true
		end

		it 'should take an Attack Boost action with action_id = 10 for player 2' do

			results = Game::take_action("10", @game)
			x = results.include? "a"

			expect(x).to eq true
		end

		it 'should take an Armor Boost action with action_id = 11 for player 2' do

			results = Game::take_action("11", @game)
			x = results.include? "o"

			expect(x).to eq true
		end

		it 'should take an Power Boost action with action_id = 12 for player 2' do
			
			results = Game::take_action("12", @game)
			x = results.include? "e"

			expect(x).to eq true
		end

		it 'should take an Poisoning Attack action with action_id = 13 for player 2' do

			results = Game::take_action("13", @game)
			x = results.include? "oison"

			expect(x).to eq true
		end

		it 'should take an Silencing Attack action with action_id = 14 for player 2' do

			results = Game::take_action("14", @game)
			x = results.include? "e"

			expect(x).to eq true
		end

		it 'should take an Confusing Attack action with action_id = 15 for player 2' do
		
			results = Game::take_action("15", @game)
			x = results.include? "fus"

			expect(x).to eq true
		end

		it 'should take an Locking Attack action with action_id = 16 for player 2' do

			results = Game::take_action("16", @game)
			x = results.include? "ock"

			expect(x).to eq true
		end

		it 'should take an Defense Break action with action_id = 17 for player 2' do
			
			results = Game::take_action("17", @game)
			x = results.include? "ense"

			expect(x).to eq true
		end

		it 'should take an Armor Break action with action_id = 18 for player 2' do
			
			results = Game::take_action("18", @game)
			x = results.include? "mor"

			expect(x).to eq true
		end

		it 'should take an Attack Break action with action_id = 19 for player 2' do
			
			results = Game::take_action("19", @game)
			x = results.include? "ack"

			expect(x).to eq true
		end

		it 'should take an Power Break action with action_id = 20 for player 2' do
			
			results = Game::take_action("20", @game)
			x = results.include? "ow"

			expect(x).to eq true
		end

		it 'should take an Charge action with action_id = 21 for player 2' do
			
			results = Game::take_action("21", @game)
			x = results.include? "a"

			expect(x).to eq true
		end		

		it 'should take an Summon action with action_id = 22 for player 2' do
			
			results = Game::take_action("22", @game)
			x = results.include? "o"

			expect(x).to eq true
		end	

		it 'should take an Heal action with action_id = 23 for player 2' do
			
			results = Game::take_action("22", @game)
			x = results.include? "e"

			expect(x).to eq true
		end		

	end

	describe 'taking a turn as player 2 without any mana' do

		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end

 		before(:each) do
 			@game.p2_mp = 0
 			@game.current_turn = 2
			@game.p1_guard = "f"
			@game.p2_guard = "f"
 		end


		it 'should take an accurate attack action with action_id = 4 for player 2' do

			results = Game::take_action("4", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an powerful attack action with action_id = 5 for player 2' do

			results = Game::take_action("5", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an accurate attack action with action_id = 6 for player 2' do
			
			results = Game::take_action("6", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an accurate attack action with action_id = 7 for player 2' do

			results = Game::take_action("7", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Focusing action with action_id = 8 for player 2' do
			
			results = Game::take_action("8", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Defense Boost action with action_id = 9 for player 2' do

			results = Game::take_action("9", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Attack Boost action with action_id = 10 for player 2' do

			results = Game::take_action("10", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Armor Boost action with action_id = 11 for player 2' do

			results = Game::take_action("11", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Power Boost action with action_id = 12 for player 2' do
			
			results = Game::take_action("12", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Poisoning Attack action with action_id = 13 for player 2' do

			results = Game::take_action("13", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Silencing Attack action with action_id = 14 for player 2' do

			results = Game::take_action("14", @game)
			x = results.include? "e"

			expect(x).to eq true
		end

		it 'should take an Confusing Attack action with action_id = 15 for player 2' do
		
			results = Game::take_action("15", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Locking Attack action with action_id = 16 for player 2' do

			results = Game::take_action("16", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Defense Break action with action_id = 17 for player 2' do
			
			results = Game::take_action("17", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Armor Break action with action_id = 18 for player 2' do
			
			results = Game::take_action("18", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Attack Break action with action_id = 19 for player 2' do
			
			results = Game::take_action("19", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Power Break action with action_id = 20 for player 2' do
			
			results = Game::take_action("20", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end

		it 'should take an Charge action with action_id = 21 for player 2' do
			
			results = Game::take_action("21", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end		

		it 'should take an Summon action with action_id = 22 for player 2' do
			
			results = Game::take_action("22", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end	

		it 'should take an Heal action with action_id = 23 for player 2' do
			
			results = Game::take_action("22", @game)
			x = results.include? "doesn't"

			expect(x).to eq true
		end		

	end

	describe 'conditions not expired for player 1 ' do

		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end

 		before(:each) do
 			@game.p1_mp = 100
 			@game.current_turn = 3
			@game.p1_guard = "f"
			@game.p2_guard = "f"
			@game.player1_buff_start = 1
			@game.player1_debuff_start = 1
			@game.player1_buff = "None"
			@game.player1_debuff = "None"
 		end

 		it 'should show the player has Defense Up' do
 			@game.player1_buff = "Defense UP"

 			results = Game::take_action("1", @game)
			x = results.include? "e"

			expect(x).to eq true

 		end

 		it 'should show the player has Attack Up' do
 			@game.player1_buff = "Attack UP"

 			results = Game::take_action("1", @game)
			x = results.include? "k"

			expect(x).to eq true

 		end

 		it 'should show the player has Power Up' do
 			@game.player1_buff = "Power UP"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Armor Up' do
 			@game.player1_buff = "Armor UP"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Mana Regeneration' do
 			@game.player1_buff = "Mana Regeneration"

 			results = Game::take_action("1", @game)
			x = results.include? "ana"

			expect(x).to eq true

 		end

 		it 'should show the player has Charge' do
 			@game.player1_buff = "Charge"

 			results = Game::take_action("1", @game)
			x = results.include? "a"

			expect(x).to eq true

 		end

 		it 'should show the player has Summon' do
 			@game.player1_buff = "Charge"

 			results = Game::take_action("1", @game)
			x = results.include? "a"

			expect(x).to eq true

 		end

 		it 'should show the player has Defense DOWN' do
 			@game.player1_debuff = "Defense DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "e"

			expect(x).to eq true

 		end

 		it 'should show the player has Attack DOWN' do
 			@game.player1_debuff = "Attack DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "k"

			expect(x).to eq true

 		end

 		it 'should show the player has Power DOWN' do
 			@game.player1_debuff = "Power DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Armor DOWN' do
 			@game.player1_debuff = "Armor DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

		
 		it 'should show the player has Confusion' do
 			@game.player1_debuff = "Confusion"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Mana Lock' do
 			@game.player1_debuff = "Mana Lock"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Poison' do
 			@game.player1_debuff = "Poison"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Silence' do
 			@game.player1_debuff = "Silence"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end
	end

	describe 'conditions not expired for player 2' do

		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end

 		before(:each) do
 			@game.p1_mp = 100
 			@game.current_turn = 4
			@game.p1_guard = "f"
			@game.p2_guard = "f"
			@game.player2_buff_start = 1
			@game.player2_debuff_start = 1
			@game.player2_buff = "None"
			@game.player2_debuff = "None"
 		end

 		it 'should show the player has Defense Up' do
 			@game.player2_buff = "Defense UP"

 			results = Game::take_action("1", @game)
			x = results.include? "e"

			expect(x).to eq true

 		end

 		it 'should show the player has Attack Up' do
 			@game.player2_buff = "Attack UP"

 			results = Game::take_action("1", @game)
			x = results.include? "k"

			expect(x).to eq true

 		end

 		it 'should show the player has Power Up' do
 			@game.player2_buff = "Power UP"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Armor Up' do
 			@game.player2_buff = "Armor UP"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Mana Regeneration' do
 			@game.player2_buff = "Mana Regeneration"

 			results = Game::take_action("1", @game)
			x = results.include? "ana"

			expect(x).to eq true

 		end

 		it 'should show the player has Charge' do
 			@game.player2_buff = "Charge"

 			results = Game::take_action("1", @game)
			x = results.include? "a"

			expect(x).to eq true

 		end

 		it 'should show the player has Summon' do
 			@game.player2_buff = "Charge"

 			results = Game::take_action("1", @game)
			x = results.include? "a"

			expect(x).to eq true

 		end

 		it 'should show the player has Defense DOWN' do
 			@game.player2_debuff = "Defense DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "e"

			expect(x).to eq true

 		end

 		it 'should show the player has Attack DOWN' do
 			@game.player2_debuff = "Attack DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "k"

			expect(x).to eq true

 		end

 		it 'should show the player has Power DOWN' do
 			@game.player2_debuff = "Power DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Armor DOWN' do
 			@game.player2_debuff = "Armor DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

		
 		it 'should show the player has Confusion' do
 			@game.player2_debuff = "Confusion"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Mana Lock' do
 			@game.player2_debuff = "Mana Lock"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Poison' do
 			@game.player2_debuff = "Poison"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Silence' do
 			@game.player2_debuff = "Silence"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end
	end

		describe 'conditions expire for player 1 ' do

		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end

 		before(:each) do
 			@game.p1_mp = 100
 			@game.current_turn = 31
			@game.p1_guard = "f"
			@game.p2_guard = "f"
			@game.player1_buff_start = 1
			@game.player1_debuff_start = 1
			@game.player1_buff = "None"
			@game.player1_debuff = "None"
 		end

 		it 'should show the player has Defense Up' do
 			@game.player1_buff = "Defense UP"

 			results = Game::take_action("1", @game)
			x = results.include? "e"

			expect(x).to eq true

 		end

 		it 'should show the player has Attack Up' do
 			@game.player1_buff = "Attack UP"

 			results = Game::take_action("1", @game)
			x = results.include? "k"

			expect(x).to eq true

 		end

 		it 'should show the player has Power Up' do
 			@game.player1_buff = "Power UP"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Armor Up' do
 			@game.player1_buff = "Armor UP"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Mana Regeneration' do
 			@game.player1_buff = "Mana Regeneration"

 			results = Game::take_action("1", @game)
			x = results.include? "ana"

			expect(x).to eq true

 		end

 		it 'should show the player has Charge' do
 			@game.player1_buff = "Charge"

 			results = Game::take_action("1", @game)
			x = results.include? "a"

			expect(x).to eq true

 		end

 		it 'should show the player has Summon' do
 			@game.player1_buff = "Charge"

 			results = Game::take_action("1", @game)
			x = results.include? "a"

			expect(x).to eq true

 		end

 		it 'should show the player has Defense DOWN' do
 			@game.player1_debuff = "Defense DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "e"

			expect(x).to eq true

 		end

 		it 'should show the player has Attack DOWN' do
 			@game.player1_debuff = "Attack DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "k"

			expect(x).to eq true

 		end

 		it 'should show the player has Power DOWN' do
 			@game.player1_debuff = "Power DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Armor DOWN' do
 			@game.player1_debuff = "Armor DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

		
 		it 'should show the player has Confusion' do
 			@game.player1_debuff = "Confusion"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Mana Lock' do
 			@game.player1_debuff = "Mana Lock"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Poison' do
 			@game.player1_debuff = "Poison"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Silence' do
 			@game.player1_debuff = "Silence"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end
	end

	describe 'conditions expire for player 2' do

		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end

 		before(:each) do
 			@game.p1_mp = 100
 			@game.current_turn = 40
			@game.p1_guard = "f"
			@game.p2_guard = "f"
			@game.player2_buff_start = 1
			@game.player2_debuff_start = 1
			@game.player2_buff = "None"
			@game.player2_debuff = "None"
 		end

 		it 'should show the player has Defense Up' do
 			@game.player2_buff = "Defense UP"

 			results = Game::take_action("1", @game)
			x = results.include? "e"

			expect(x).to eq true

 		end

 		it 'should show the player has Attack Up' do
 			@game.player2_buff = "Attack UP"

 			results = Game::take_action("1", @game)
			x = results.include? "k"

			expect(x).to eq true

 		end

 		it 'should show the player has Power Up' do
 			@game.player2_buff = "Power UP"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Armor Up' do
 			@game.player2_buff = "Armor UP"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Mana Regeneration' do
 			@game.player2_buff = "Mana Regeneration"

 			results = Game::take_action("1", @game)
			x = results.include? "ana"

			expect(x).to eq true

 		end

 		it 'should show the player has Charge' do
 			@game.player2_buff = "Charge"

 			results = Game::take_action("1", @game)
			x = results.include? "a"

			expect(x).to eq true

 		end

 		it 'should show the player has Summon' do
 			@game.player2_buff = "Charge"

 			results = Game::take_action("1", @game)
			x = results.include? "a"

			expect(x).to eq true

 		end

 		it 'should show the player has Defense DOWN' do
 			@game.player2_debuff = "Defense DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "e"

			expect(x).to eq true

 		end

 		it 'should show the player has Attack DOWN' do
 			@game.player2_debuff = "Attack DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "k"

			expect(x).to eq true

 		end

 		it 'should show the player has Power DOWN' do
 			@game.player2_debuff = "Power DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Armor DOWN' do
 			@game.player2_debuff = "Armor DOWN"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

		
 		it 'should show the player has Confusion' do
 			@game.player2_debuff = "Confusion"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Mana Lock' do
 			@game.player2_debuff = "Mana Lock"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Poison' do
 			@game.player2_debuff = "Poison"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end

 		it 'should show the player has Silence' do
 			@game.player2_debuff = "Silence"

 			results = Game::take_action("1", @game)
			x = results.include? "o"

			expect(x).to eq true

 		end
	end

	describe 'get MP Cost' do

		it 'should return the correct MP Costs' do
			mana = Game::get_MP_cost(4)
			expect(mana).to eq 10

			mana = Game::get_MP_cost(5)
			expect(mana).to eq 10

			mana = Game::get_MP_cost(6)
			expect(mana).to eq 10

			mana = Game::get_MP_cost(7)
			expect(mana).to eq 20

			mana = Game::get_MP_cost(8)
			expect(mana).to eq 10

			mana = Game::get_MP_cost(9)
			expect(mana).to eq 10

			mana = Game::get_MP_cost(10)
			expect(mana).to eq 10

			mana = Game::get_MP_cost(11)
			expect(mana).to eq 10

			mana = Game::get_MP_cost(12)
			expect(mana).to eq 10

			mana = Game::get_MP_cost(13)
			expect(mana).to eq 20

			mana = Game::get_MP_cost(14)
			expect(mana).to eq 20

			mana = Game::get_MP_cost(15)
			expect(mana).to eq 20

			mana = Game::get_MP_cost(16)
			expect(mana).to eq 20

			mana = Game::get_MP_cost(17)
			expect(mana).to eq 15

			mana = Game::get_MP_cost(18)
			expect(mana).to eq 15

			mana = Game::get_MP_cost(19)
			expect(mana).to eq 15

			mana = Game::get_MP_cost(20)
			expect(mana).to eq 15

			mana = Game::get_MP_cost(21)
			expect(mana).to eq 15

			mana = Game::get_MP_cost(22)
			expect(mana).to eq 20

			mana = Game::get_MP_cost(23)
			expect(mana).to eq 20
		end

	end
	
	describe 'get ability info' do

		before(:all) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
 		end

 		it 'should produce the correct results for the first ability' do
 			answer = Game::get_ability_info("5", "Alice")
 			expect(answer["ability_name"]).to eq @c1.action_1_name
 			expect(answer["ability_flavor"]).to eq @c1.action_1_flavor
 		end

 		it 'should produce the correct results for the second ability' do
 			answer = Game::get_ability_info("13", "Alice")
 			expect(answer["ability_name"]).to eq @c1.action_2_name
 			expect(answer["ability_flavor"]).to eq @c1.action_2_flavor
 		end

 		it 'should produce the correct results for the third ability' do
 			answer = Game::get_ability_info("8", "Alice")
 			expect(answer["ability_name"]).to eq @c1.action_3_name
 			expect(answer["ability_flavor"]).to eq @c1.action_3_flavor
 		end

 		it 'should produce the correct results for the fourth ability' do
 			answer = Game::get_ability_info("22", "Alice")
 			expect(answer["ability_name"]).to eq @c1.action_4_name
 			expect(answer["ability_flavor"]).to eq @c1.action_4_flavor
 		end

 		it 'should produce the correct results for the Attack action' do
 			answer = Game::get_ability_info("1", "Alice")
 			expect(answer["ability_name"]).to eq "Attack"
 			expect(answer["ability_flavor"]).to eq ""
 		end

 		it 'should produce the correct results for the Guard action' do
 			answer = Game::get_ability_info("2", "Alice")
 			expect(answer["ability_name"]).to eq "Guard"
 			expect(answer["ability_flavor"]).to eq ""
 		end

 		it 'should produce the correct results for the Focus action' do
 			answer = Game::get_ability_info("3", "Alice")
 			expect(answer["ability_name"]).to eq "Focus"
 			expect(answer["ability_flavor"]).to eq ""
 		end


	end

end
