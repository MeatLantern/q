class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def new
  end

  def create
  end

  def set_friends_list_empty
    users = User.all
    users.each do |user|
      user.friends_list = ""
      user.save
    end
    flash[:notice] = "Friends Lists Set to Empty String"
    redirect_to users_admin_path
  end

  def view
    
    x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]
    @current_username = z["username"]

    if params["current"] == "true"
      @username = @current_username
    else
      @username = params["name"]
    end

    @username = @current_username

    @characters = Character.where(:creator => @username)
    @characters = @characters.order('created_at ASC')
    #binding.pry
    if @characters.nil?
      @characters = []
    end

    if !(@characters.respond_to?('each'))
      x = @characters
      @characters = [x]
    end

    @reports = Report.where(:reporter => @current_username)

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    if !@user.currentgame.nil?
      Game.find_by_game_name(@user.currentgame).destroy
    end
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_admin_url  
  end

  def add_admin
    @user = User.find(params[:id])
    @user.is_admin = true;
    @user.save
    redirect_to users_admin_url
  end

  def remove_admin
    @user = User.find(params[:id])
    @user.is_admin = false;
    @user.save
    redirect_to users_admin_url
  end

  def show
    # routing hot fix I don't know why this happens
    if params[:id] == 'admin'
      admin
    else
      @username = User.find(params[:id]).username
      @characters = Character.find_by_creator(@username)
      if @characters.nil?
        @characters = []
      end
    end
  end

  def admin
    if current_user.is_admin
      @users = User.all
      render :template => "/users/admin"
    else
      redirect_to users_url
    end
  end

  def update_profile
    new_profile = params[:transformation][:profile]
    #binding.pry
    if new_profile.nil?
      flash[:alert] = "Profile Not Updated, no New Profile Was Sent."
      redirect_to view_path
    else
      current_user.profile = new_profile
      current_user.save
      flash[:notice] = "Profile Updated"
      redirect_to view_path
    end
  end

  def public_profile
    @user = User.find_by_username(params[:username])
    if @user.nil?
      flash[:alert] = "The Player Could Not Be Found."
      redirect_to view_all_players_path
    end
    @characters = Character.where(:creator => @user.username)
    @characters = @characters.order('created_at ASC')
  end

  def view_all_players
    search_hash = {}
    search_hash[:is_admin] = true
    @admins = User.where(search_hash)
    search_hash = {}
    @players = User.where(search_hash)
    @players = @players.order('username ASC')
    friends_array = current_user.friends_list.split(" ")
    #binding.pry
    @friends = []
    i = 0 
    friends_array.each do |friend|
      f = User.find_by_username(friend)
      if !(f.nil?)
        @friends[i] = f
        i = i + 1
      end
    end
    #@friends = @friends.order('username ASC')
    #binding.pry

  end

  def add_to_friends_list
    user = User.find_by_username(params[:username])
    if user.nil?
      flash[:alert] = "Username Not Found."
      redirect_to(:back) 
    else
      if current_user.friends_list.include?(user.username)
        flash[:alert] = "This Player is Already on Your Friends List"
        redirect_to(:back)
      else
        current_user.friends_list = current_user.friends_list + " " + user.username
        current_user.save
        flash[:notice] = "#{user.username} has been added to your Friends List!"
        redirect_to(:back)
      end
    end
  end

  def remove_from_friends_list
    user = User.find_by_username(params[:username])
    if user.nil?
      flash[:alert] = "Username Not Found."
      redirect_to(:back) 
    else
      if current_user.friends_list.include?(user.username)
        current_user.friends_list = current_user.friends_list.gsub(user.username, '')
        current_user.save
        flash[:notice] = "#{user.username} has been removed from your Friends List."
        redirect_to(:back)
      else
        flash[:alert] = "This Player is not on Your Friends List."
        redirect_to(:back)
      end
    end
  end

  def edit_rp_pref
    rp_pref = params["transformation"]["rp_pref"]
    if rp_pref.nil?
      flash[:alert] = "The New Preference was not Sent. Please try again."
      redirect_to(:back)
    else
      current_user.rp_pref = rp_pref
      current_user.save
      flash[:notice] = "Rp Preferences have been changed to '#{rp_pref}'"
      redirect_to(:back)
    end
  end

  def edit_fave_tf
    fave_tf = params["transformation"]["fave_tf"]
    if fave_tf.nil?
      flash[:alert] = "The New Favorite TF was not Sent. Please try again."
      redirect_to(:back)
    else
      current_user.fave_tf = fave_tf
      current_user.save
      flash[:notice] = "Favorite TF have been changed to '#{fave_tf}'"
      redirect_to(:back)
    end
  end

  
end
