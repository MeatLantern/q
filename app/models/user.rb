class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :currentgame, :email, :password, :password_confirmation, :remember_me, :username, :is_admin
  # attr_accessible :title, :body
    
  validates_uniqueness_of :username
  
end
