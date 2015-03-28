class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :currentgame, :email, :password, :password_confirmation, :remember_me, :username, :is_admin
  # attr_accessible :title, :body
    
  validates_uniqueness_of :username

  #acts_as_messageable

  def name
  	return current_user.username
  end

  def mailboxer_email
  	return current_user.email
  end
  
end
