class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :check_18!
  before_filter :set_unread_messages

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
end
