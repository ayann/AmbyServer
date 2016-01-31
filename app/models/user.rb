class User < ActiveRecord::Base
  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  validates :name, presence: true, uniqueness: true

  before_create do |user|
    self.token = SecureRandom.hex
  end
end
