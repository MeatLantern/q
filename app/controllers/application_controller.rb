class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :check_18!
  before_filter :set_unread_messages
  before_filter :check_if_in_game
  private

  def check_18!
  	unless session[:is_18].nil? == false
  		flash[:error] = "You must confirm your age before continuing."
  		redirect_to check_18_path
  	end
  end

  def set_unread_messages
    search_hash = {}
    search_hash[:is_read] = false
    search_hash[:receiver] = current_user.username 
    unread_messages = Message.where(search_hash)
    session[:unread] = "View Messages (#{unread_messages.count})"
  end

  def check_if_in_game
      game_name = current_user.currentgame
      #binding.pry
      if !(game_name.nil?)
        current_game = Game.find_by_game_name(game_name)
        if(current_game.nil?)
          #redirect_to game_game_not_found_path
          flash[:alert] = "Your Game Has Ended. Your Opponent may have Left the Game."
          current_user.currentgame = nil
          current_user.save
          session[:current_game] = nil
        else
          session[:current_game] = current_game.game_name
        end
      else
          session[:current_game] = nil 
      end
  end

end
