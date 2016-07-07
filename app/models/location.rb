class Location < ActiveRecord::Base
  belongs_to :user
  has_many :shared_locations
  has_many :shared_with_users, through: :shared_locations, source: :friend

  scope :published, -> { where(public: true) }
end
