class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "user_b"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  # has_many :mutual_friends, 
  #        :through => :inverse_friendships,
  #        :source => :user,
  #         -> { where.associated(:user_a, :user_b) }

  def active_friends
    friends.select{ |friend| friend.friends.include?(self) }  
  end
  
  def pending_friends
    friends.select{ |friend| !friend.friends.include?(self) }  
  end

  def mutual_friends
    inverse_friends.joins(:friendships).where("friendships.user_a = users.id and friendships.user_b = :self_id", :self_id => id).all
  end
end