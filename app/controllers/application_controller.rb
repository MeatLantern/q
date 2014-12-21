class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :check_18!

  private

  def check_18!
  	unless session[:is_18].nil? == false
  		flash[:error] = "You must confirm your age before continuing."
  		redirect_to check_18_path
  	end
  end
end
