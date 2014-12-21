class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def new
  end

  def create
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
    #binding.pry
    if @characters.nil?
      @characters = []
    end

    if !(@characters.respond_to?('each'))
      x = @characters
      @characters = [x]
    end

    #binding.pry
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
end
