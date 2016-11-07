class Favorite < ApplicationRecord
    validates_presence_of :deviceid, :placeid
    belongs_to :device
    belongs_to :place
end
