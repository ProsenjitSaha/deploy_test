class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id

  has_many :friends, -> { where(friendships: { status: "accepted" }) }, through: :friendships
  has_many :inverse_friends, -> { where(friendships: { status: "accepted" }) }, through: :inverse_friendships, source: :user

  has_many :pending_friends, -> { where(friendships: { status: "pending" }) }, through: :friendships, source: :friend
  has_many :requested_friends, -> { where(friendships: { status: "pending" }) }, through: :inverse_friendships, source: :user

  has_many :locations
  has_many :shared_with_locations, class_name: "SharedLocation", foreign_key: :friend_id
  has_many :inverse_locations, through: :shared_with_locations , source: :location

  def mutual_friends
    friends | inverse_friends
  end

  def has_friendship?(user)
    mutual_friends.collect(&:id).include?(user.id)
  end

  def pending_friendship?(user)
    pending_friends.pluck(:friend_id).include?(user.id)
  end

  def requested_friendships?(user)
    requested_friends.pluck(:user_id).include?(user.id)
  end

  def visible_locations(current_user)
    locations.published | current_user.inverse_locations
  end
end
