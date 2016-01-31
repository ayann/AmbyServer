class Room < ActiveRecord::Base
  enum state: [
    :active,
    :unactive
  ]
end
