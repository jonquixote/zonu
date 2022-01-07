class Friendship < ActiveRecord::Base
    belongs_to :user
    belongs_to :friend, :class_name => "User", foreign_key: "user_b"
    validates_uniqueness_of :friend, scope: :user
    validate :check_user
    def check_user
      if self.user_b == self.user_a
        errors.add(:friend, "can't be yourself")
      end
    end
end