class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  # has_many :mutual_friends, 
  #        :through => :inverse_friendships,
  #        :source => :user,
  #         -> { where.associated(:user_id, :friend_id) }

  def active_friends
    friends.select{ |friend| friend.friends.include?(self) }  
  end
  
  def pending_friends
    friends.select{ |friend| !friend.friends.include?(self) }  
  end

  def mutual_friends
    inverse_friends.joins(:friendships).where("friendships.user_id = users.id and friendships.friend_id = :self_id", :self_id => id).all
  end
end