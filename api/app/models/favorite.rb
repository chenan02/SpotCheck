class Favorite < ApplicationRecord
    validates_presence_of :deviceid, :placeid
end
