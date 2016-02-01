class Room < ActiveRecord::Base
  has_many :user_rooms
  has_many :users, through: :user_rooms

  enum state: [
    :active,
    :unactive
  ]

  before_create do
    self.name = SecureRandom.hex(4)
  end

  def self.free
    active.includes(:user_rooms).select { |x| x.user_rooms.count < 5 }
  end
end
