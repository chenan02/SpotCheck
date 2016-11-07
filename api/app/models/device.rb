class Device < ApplicationRecord
    validates_presence_of :deviceid
    validates_uniqueness_of :deviceid
end
