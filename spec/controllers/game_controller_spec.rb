require 'rails_helper'
require 'spec_helper'

RSpec.describe GameController, :type => :controller do
	include Devise::TestHelpers
  	before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  	end
	describe 'showing game' do

		before(:each) do
 			@c1 = Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Freezing Touch, Frozen Concentration, Summon Snowman", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/Alice_zps420c377b.png", :action_1_id => 5, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "Powerful Attack", :action_2_id => 13, :action_2_name => "Freezing Touch", :action_2_flavor => "Alice strikes her enemy with a brutal, sickening cold that spreads through them slowly.", :action_2_rules => "Poisoning Attack", :action_3_id => 8, :action_3_name => "Frozen Concentration", :action_3_flavor => "Alice hones her mind on the frozen air, allowing her to cast more easily.", :action_3_rules => "Focusing Action", :action_4_id => 22, :action_4_name => "Summon Snowman", :action_4_flavor => "Alice summons a deadly snowman to attack her enemies for her.", :action_4_rules => "Summon Ally", :summon_name => "Snowman", :summon_attack => 'The snowman strikes with deadly frost!', :summon_picture => "http://cdn.bulbagarden.net/upload/4/4d/Spr_3r_378_s.png", :creator => "User1")
			@c2 = Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 80, :max_mp => 70, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Heroic Strike, Summon Squire, Might of Heroism", :main_image => "http://i1376.photobucket.com/albums/ah9/mzucco/EliwoodKnightLordLancePic_zpsdff518cf.png", :action_1_id => 9, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line, blocking attacks.", :action_1_rules => "Defense Boost", :action_2_id => 4, :action_2_name => "Heroic Strike", :action_1_flavor => "Bob makes a quick and accurate attack with his blade.", :action_2_rules => "Accurate Attack.", :action_3_id => 22, :action_3_name => "Summon Squire", :action_3_flavor => "Bob summons his trusty squire to aid him in battle.", :action_3_rules => "Summon Ally", :action_4_id => 7, :action_4_name => "Might of Heroism", :action_4_flavor => "Bob calls upon all of his power for a brutal, devastating strke.", :action_4_rules => "Overwhelming Attack", :summon_name => "Amelia the Squire", :summon_attack => "Amelia helps her master with a quick lance attack!", :summon_picture => "http://i1376.photobucket.com/albums/ah9/mzucco/BobsSquirePic_zps332e1de2.png", :creator => "User1")
			#Initialize a Game for Testing Purposes
			@game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "None", :player1_buff_start => 0, :player2_buff => "None", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 80, :p1_mp => 100, :p2_mp => 70, :p1_guard => "f", :p2_guard => "f", :game_over => false)  
 		end
		
		it 'should redirect to the game_not_found path without a valid session token' do
			#Game.create!(create_hash)
			get :show

			expect(response).to have_http_status(302)
		end

		it 'should render the view when you have a valid game token' do
			session[:current_game] = "test"
			get :show
			expect(response).to have_http_status(200)

		end

		it 'should take an action when it is sent an action' do
			#Initialize Characters
			Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Ice Shield, Frozen Concentration, Summon Snowman", :main_image => "http://img-cache.cdn.gaiaonline.com/99d22176f9e7690104d821ea2d6dcb50/http://i173.photobucket.com/albums/w60/Yuki-mew-mew/anime/mage.jpg", :action_1_id => 1, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "5 mp, Boosted Power")
			Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 55, :max_mp => 50, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Excalibur!, Summon Squire, Might of Heroism", :main_image => "http://cache.desktopnexus.com/thumbnails/794290-bigthumbnail.jpg", :action_1_id => 5, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line!", :action_1_rules => "5 mp, Boosted Power")
			#Initialize a Game for Testing Purposes
			game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 5, :game_over => false) 
			session[:current_game] = "test"

			post :take_turn, {"Action" => "1"}
			expect(response).to have_http_status(302)
		end

		it 'should let the AI take Actions' do
			#Initialize Characters
			Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Ice Shield, Frozen Concentration, Summon Snowman", :main_image => "http://img-cache.cdn.gaiaonline.com/99d22176f9e7690104d821ea2d6dcb50/http://i173.photobucket.com/albums/w60/Yuki-mew-mew/anime/mage.jpg", :action_1_id => 1, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "5 mp, Boosted Power")
			Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 55, :max_mp => 50, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Excalibur!, Summon Squire, Might of Heroism", :main_image => "http://cache.desktopnexus.com/thumbnails/794290-bigthumbnail.jpg", :action_1_id => 5, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line!", :action_1_rules => "5 mp, Boosted Power")
			#Initialize a Game for Testing Purposes
			game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 2, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 5, :game_over => false) 
			session[:current_game] = "test"

			post :ai_take_turn, {"Action" => "1"}
			expect(response).to have_http_status(302)
		end

		it 'should change the stats back to inital when told to reset' do
			#Initialize Characters
			Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Ice Shield, Frozen Concentration, Summon Snowman", :main_image => "http://img-cache.cdn.gaiaonline.com/99d22176f9e7690104d821ea2d6dcb50/http://i173.photobucket.com/albums/w60/Yuki-mew-mew/anime/mage.jpg", :action_1_id => 1, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "5 mp, Boosted Power")
			Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 55, :max_mp => 50, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Excalibur!, Summon Squire, Might of Heroism", :main_image => "http://cache.desktopnexus.com/thumbnails/794290-bigthumbnail.jpg", :action_1_id => 5, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line!", :action_1_rules => "5 mp, Boosted Power")
			#Initialize a Game for Testing Purposes
			game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 2, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 5, :game_over => false) 
			session[:current_game] = "test"

			post :cpu_reset_game

			expect(50).to eq game.p1_hp
			expect(response).to have_http_status(302)
		end

		it 'should create a new AI game and change the session to the new value' do
			#Initialize Characters
			Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Ice Shield, Frozen Concentration, Summon Snowman", :main_image => "http://img-cache.cdn.gaiaonline.com/99d22176f9e7690104d821ea2d6dcb50/http://i173.photobucket.com/albums/w60/Yuki-mew-mew/anime/mage.jpg", :action_1_id => 1, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "5 mp, Boosted Power")
			Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 55, :max_mp => 50, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Excalibur!, Summon Squire, Might of Heroism", :main_image => "http://cache.desktopnexus.com/thumbnails/794290-bigthumbnail.jpg", :action_1_id => 5, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line!", :action_1_rules => "5 mp, Boosted Power")
			#Initialize a Game for Testing Purposes
			game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 2, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 5, :game_over => false) 
			session[:current_game] = "test"

			post :create_ai_game, {:name => "Alice"}

			expect(session[:current_game]).to_not eq "test"
			expect(response).to have_http_status(302)
		end

		it 'should not redirect to game_not_found when called' do
			#Initialize Characters
			Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Ice Shield, Frozen Concentration, Summon Snowman", :main_image => "http://img-cache.cdn.gaiaonline.com/99d22176f9e7690104d821ea2d6dcb50/http://i173.photobucket.com/albums/w60/Yuki-mew-mew/anime/mage.jpg", :action_1_id => 1, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "5 mp, Boosted Power")
			Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 55, :max_mp => 50, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Excalibur!, Summon Squire, Might of Heroism", :main_image => "http://cache.desktopnexus.com/thumbnails/794290-bigthumbnail.jpg", :action_1_id => 5, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line!", :action_1_rules => "5 mp, Boosted Power")
			#Initialize a Game for Testing Purposes
			game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 2, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 5, :game_over => false) 
			session[:current_game] = "x"

			post :destroy_current_game, {"Action" => "1"}

			#expect(session[:current_game]).to_not eq "test"
			expect(response).to have_http_status(302)
		end


		it 'should load the game not found view when called' do
			#Initialize Characters
			Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Ice Shield, Frozen Concentration, Summon Snowman", :main_image => "http://img-cache.cdn.gaiaonline.com/99d22176f9e7690104d821ea2d6dcb50/http://i173.photobucket.com/albums/w60/Yuki-mew-mew/anime/mage.jpg", :action_1_id => 1, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "5 mp, Boosted Power")
			Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 55, :max_mp => 50, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Excalibur!, Summon Squire, Might of Heroism", :main_image => "http://cache.desktopnexus.com/thumbnails/794290-bigthumbnail.jpg", :action_1_id => 5, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line!", :action_1_rules => "5 mp, Boosted Power")
			#Initialize a Game for Testing Purposes
			game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 5, :game_over => false) 
			session[:current_game] = "test"
			get :game_not_found
			expect(response).to have_http_status(302)
		end

		it 'should load the rules view when called' do
			#Initialize Characters
			Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Ice Shield, Frozen Concentration, Summon Snowman", :main_image => "http://img-cache.cdn.gaiaonline.com/99d22176f9e7690104d821ea2d6dcb50/http://i173.photobucket.com/albums/w60/Yuki-mew-mew/anime/mage.jpg", :action_1_id => 1, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "5 mp, Boosted Power")
			Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 55, :max_mp => 50, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Excalibur!, Summon Squire, Might of Heroism", :main_image => "http://cache.desktopnexus.com/thumbnails/794290-bigthumbnail.jpg", :action_1_id => 5, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line!", :action_1_rules => "5 mp, Boosted Power")
			#Initialize a Game for Testing Purposes
			game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 5, :game_over => false) 
			session[:current_game] = "test"
			get :rules
			expect(response).to have_http_status(200)
		end

		it 'should load the game leave_game view when called' do
			#Initialize Characters
			Character.create!(:name => "Alice", :description => "Alice is a powerful wizard with mastery over ice and snow. She has an icy demeanor that hides a warm, kind heart.", :max_hp => 50, :max_mp => 100, :base_attack => 5, :base_power => 6, :base_defense => 6, :base_armor => 4, :actions => "Ice Blast, Ice Shield, Frozen Concentration, Summon Snowman", :main_image => "http://img-cache.cdn.gaiaonline.com/99d22176f9e7690104d821ea2d6dcb50/http://i173.photobucket.com/albums/w60/Yuki-mew-mew/anime/mage.jpg", :action_1_id => 1, :action_1_name => "Ice Blast", :action_1_flavor => "Alice freezes her foe with a deadly blast of cold", :action_1_rules => "5 mp, Boosted Power")
			Character.create!(:name => "Bob", :description => "Bob is a brave knight with a powerful sword and a mighty shield. He has a stone face but a heart of gold.", :max_hp => 55, :max_mp => 50, :base_attack => 5, :base_power => 5, :base_defense => 5, :base_armor => 6, :actions => "Frontline Defender, Excalibur!, Summon Squire, Might of Heroism", :main_image => "http://cache.desktopnexus.com/thumbnails/794290-bigthumbnail.jpg", :action_1_id => 5, :action_1_name => "Frontline Defender", :action_1_flavor => "Bob shows his heriosm and moves to the front line!", :action_1_rules => "5 mp, Boosted Power")
			#Initialize a Game for Testing Purposes
			game = Game.create!(:game_name => "test", :player1 => "testUser1", :player2 => "testUser2", :player1_character => "Alice", :player2_character => "Bob", :player1_message => "Hi!", :player2_message => "Lol this game sucks", :current_turn => 1, :player1_buff => "none", :player1_buff_start => 0, :player2_buff => "Power UP", :player2_buff_start => 1, :player1_debuff => "Poison", :player1_debuff_start => 1, :player2_debuff => "None", :player2_debuff_start => 0, :p1_hp => 50, :p2_hp => 50, :p1_mp => 10, :p2_mp => 5, :game_over => false) 
			session[:current_game] = "test"
			get :leave_game
			expect(response).to have_http_status(200)
		end
		
	end

end
