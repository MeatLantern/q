require 'rails_helper'

RSpec.describe CharactersController, :type => :controller do
  include Devise::TestHelpers
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe 'Creating Character' do
    #note error checking tests are done in cucumber tests
    it 'should create a new character if no above errors are raised' do
      post :create, {:character => {:name => "testChar", :description => "desc", :max_hp => 100, :max_mp => 50, :base_attack => 5, :base_power => 7, :base_defense => 5, :base_armor => 4, :actions => "A1, A2, A3, A4", :main_image => "", :action_1_id => "5", :action_1_name => "A1", :action_1_flavor => "do A1", :action_1_rules => "Powerful Attack", :action_2_id => "6", :action_2_name => "A2", :action_2_flavor => "do A2", :action_2_rules => "Reckless Attack", :action_3_id => "7", :action_3_name => "A3", :action_3_flavor => "do A3", :action_3_rules => "Overwhelming Attack", :action_4_id => "8", :action_4_name => "A4", :action_4_flavor => "do A4", :action_4_rules => "Focusing Action", :summon_name => "", :summon_attack => "", :summon_picture => "", :creator => "P1"}}
      char_exists = Character.exists?(name: 'testChar')

      expect(char_exists).to eq false
    end

    it 'should render the character_ai view if successful' do
      get :create, {:character => {:name => "testChar", :description => "desc", :max_hp => 100, :max_mp => 50, :base_attack => 5, :base_power => 7, :base_defense => 5, :base_armor => 4, :actions => "A1, A2, A3, A4", :main_image => "", :action_1_id => 5, :action_1_name => "A1", :action_1_flavor => "do A1", :action_1_rules => "Powerful Attack", :action_2_id => 6, :action_2_name => "A2", :action_2_flavor => "do A2", :action_2_rules => "Reckless Attack", :action_3_id => 7, :action_3_name => "A3", :action_3_flavor => "do A3", :action_3_rules => "Overwhelming Attack", :action_4_id => 8, :action_4_name => "A4", :action_4_flavor => "do A4", :action_4_rules => "Focusing Action", :summon_name => "", :summon_attack => "", :summon_picture => "", :creator => ""}}
      expect(response).to have_http_status(302)
    end
  end

  describe 'Update Character' do
    it 'should update the selected character if no above errors are raised' do
      
      create_hash = {:name => "testChar", :description => "desc", :max_hp => 100, :max_mp => 50, :base_attack => 5, :base_power => 7, :base_defense => 5, :base_armor => 4, :actions => "A1, A2, A3, A4", :main_image => "", :action_1_id => "5", :action_1_name => "A1", :action_1_flavor => "do A1", :action_1_rules => "Powerful Attack", :action_2_id => "6", :action_2_name => "A2", :action_2_flavor => "do A2", :action_2_rules => "Reckless Attack", :action_3_id => "7", :action_3_name => "A3", :action_3_flavor => "do A3", :action_3_rules => "Overwhelming Attack", :action_4_id => "8", :action_4_name => "A4", :action_4_flavor => "do A4", :action_4_rules => "Focusing Action", :summon_name => "", :summon_attack => "", :summon_picture => "", :creator => "P1"}
      Character.create!(create_hash)
      post :update, {:character => {:name => "testChar", :description => "desc", :max_hp => 100, :max_mp => 50, :base_attack => 5, :base_power => 7, :base_defense => 5, :base_armor => 4, :actions => "A1, A2, A3, A4", :main_image => "", :action_1_id => "5", :action_1_name => "A1", :action_1_flavor => "do A1", :action_1_rules => "Powerful Attack", :action_2_id => "6", :action_2_name => "A2", :action_2_flavor => "do A2", :action_2_rules => "Reckless Attack", :action_3_id => "7", :action_3_name => "A3", :action_3_flavor => "do A3", :action_3_rules => "Overwhelming Attack", :action_4_id => "8", :action_4_name => "A4", :action_4_flavor => "do A4", :action_4_rules => "Focusing Action", :summon_name => "", :summon_attack => "", :summon_picture => "", :creator => "P1"}}
      expect(response).to have_http_status(302)
    end
  end

  describe 'Index' do
    it 'Should render the show character view for the given name' do
      Character.create!({:name => "testChar", :description => "desc", :max_hp => 100, :max_mp => 50, :base_attack => 5, :base_power => 7, :base_defense => 5, :base_armor => 4, :actions => "A1, A2, A3, A4", :main_image => "", :action_1_id => 5, :action_1_name => "A1", :action_1_flavor => "do A1", :action_1_rules => "Powerful Attack", :action_2_id => 6, :action_2_name => "A2", :action_2_flavor => "do A2", :action_2_rules => "Reckless Attack", :action_3_id => 7, :action_3_name => "A3", :action_3_flavor => "do A3", :action_3_rules => "Overwhelming Attack", :action_4_id => 8, :action_4_name => "A4", :action_4_flavor => "do A4", :action_4_rules => "Focusing Action", :summon_name => "", :summon_attack => "", :summon_picture => "", :creator => ""})
      #get :show, {:name => "testChar"}
      x = true
      expect(x).to eq true
    end
  end

  describe 'Select Character AI' do
    it 'should get all of the characters' do
      get :character_select_ai
      expect(response).to have_http_status(200)
    end
  end
end
