class Place < ApplicationRecord
    validates_presence_of :placeid, :occupancy
    validates_uniqueness_of :placeid
    has_many :devices, through: :favorites
end
