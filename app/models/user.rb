class User < ActiveRecord::Base
  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  validates :name, presence: true, uniqueness: true

  before_create do |user|
    self.token = SecureRandom.hex
  end

  def join_in room
    self.user_rooms.build(room: room).save!
  end

  def unjoin room
    self.user_rooms.where(room: room).last.destroy
  end

  def room
    room = self.rooms.active.last
    return room if room.present?

    if Room.active.any?
      self.join_in(Room.free.first)
    else
      self.join_in(Room.new(state: 0))
    end
    self.rooms.active.last
  end
end
